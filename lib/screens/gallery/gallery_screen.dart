import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/gallery_constant.dart';

import 'bloc/gallery_bloc.dart';

class GalleryScreen extends StatelessWidget {
  final String type;
  final String option;
  final Function(List<File> files)? callBackMulti;
  final Function(File file)? callBackSingle;

  GalleryScreen(
      {this.type = GalleryConstants.all,
      this.option = GalleryConstants.single,
      this.callBackMulti,
      this.callBackSingle});

  late GalleryBloc _galleryBloc;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc()..add(GalleryInitialEvent(type: type)),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    _galleryBloc = BlocProvider.of<GalleryBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _galleryBloc.add(GalleryGetFromSource());
      }
    });
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: 20,
                  ),
                  BlocBuilder<GalleryBloc, GalleryState>(
                    bloc: _galleryBloc,
                    builder: (BuildContext context, state) {
                      return DropdownButton(
                        value: state.sourceSelected,
                        onChanged: (value) {
                          _galleryBloc.add(UpdateSourceSelected(
                              sourceSelected: value as String));
                        },
                        items: state.sources
                            .map((source) => DropdownMenuItem(
                                value: source, child: Text('$source')))
                            .toList(),
                      );
                    },
                  ),
                  Spacer(),
                  option == GalleryConstants.multi
                      ? InkWell(
                          onTap: () {},
                          child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Center(child: Text('Send'))))
                      : Container(),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<GalleryBloc, GalleryState>(
                  bloc: _galleryBloc,
                  buildWhen: (previous, current) =>
                      current.status == GalleryStatus.getFromSourceSuccess ||
                      current.status == GalleryStatus.selectFileSuccess,
                  builder: (BuildContext context, state) {
                    return Container(
                      child: GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          shrinkWrap: true,
                          itemCount: state.medias.length,
                          itemBuilder: (context, index) {
                            final media = state.medias[index];
                            bool isSelected =
                                state.mediasSelected.contains(media);
                            return Stack(
                              children: [
                                InkWell(
                                  key: ValueKey(media.path),
                                  onTap: () {
                                    if (option == GalleryConstants.single) {
                                      processSingle(media, context);
                                    } else {
                                      _galleryBloc
                                          .add(SelectFileEvent(file: media));
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 3, bottom: 3),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(media),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                state.mediasSelected.isNotEmpty && isSelected
                                    ? Positioned(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  width: 2, color: Colors.grey),
                                              color: Colors.white),
                                          height: 30,
                                          width: 30,
                                          child: Center(
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                        top: 5,
                                        right: 5,
                                      )
                                    : Container(),
                              ],
                            );
                          }),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              BlocBuilder<GalleryBloc, GalleryState>(
                  bloc: _galleryBloc,
                  builder: (context, state) {
                    if (state.status == GalleryStatus.loading) {
                      return CircularProgressIndicator();
                    }
                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }

  void processSingle(File file, BuildContext context) {
    callBackSingle!(file);
    Navigator.pop(context);
  }
}
