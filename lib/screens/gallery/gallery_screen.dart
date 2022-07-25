import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/gallery_constant.dart';
import 'package:social_network_mobile_ui/screens/gallery/components/media_card.dart';

import 'bloc/gallery_bloc.dart';

class GalleryScreen extends StatelessWidget {
  final String type;
  final String option;
  final Function(Set<File> files)? callBackMulti;
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
                        style: TextStyle(color: Colors.white, fontSize: 18),
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
                  BlocBuilder<GalleryBloc, GalleryState>(
                      bloc: _galleryBloc,
                      buildWhen: (previous, current) =>
                          current.status == GalleryStatus.initial,
                      builder: (context, state) {
                        if (option == GalleryConstants.multi) {
                          return InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                if (callBackMulti != null) {
                                  callBackMulti!(state.mediasSelected);
                                  Navigator.pop(context);
                                }
                              },
                              child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                      child: Icon(
                                    Icons.send,
                                    color: Colors.blue.withOpacity(0.9),
                                  ))));
                        }
                        return Container();
                      }),
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
                    return Stack(children: [
                      GridView.builder(
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
                                    onLongPress: () {
                                      _galleryBloc
                                          .add(PreviewFileEvent(file: media));
                                    },
                                    child: MediaCard(media)),
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
                      BlocBuilder<GalleryBloc, GalleryState>(
                          bloc: _galleryBloc,
                          buildWhen: (previous, current) =>
                              current.status ==
                                  GalleryStatus.previewFileSuccess ||
                              current.status ==
                                  GalleryStatus.stopPreviewFileSuccess,
                          builder: (context, state) {
                            if (state.status ==
                                GalleryStatus.previewFileSuccess) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 5.0,
                                      sigmaY: 5.0,
                                    ),
                                    child: Container(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  Stack(children: [
                                    Container(
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Container(
                                              height: 350,
                                              width: 350,
                                              child: MediaCard(
                                                  state.previewFile!)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: InkWell(
                                        onTap: () {
                                          _galleryBloc
                                              .add(StopPreviewFileEvent());
                                        },
                                        child: Container(
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                      right: 45,
                                      top: 10,
                                    ),
                                  ]),
                                ],
                              );
                            }
                            return Container();
                          }),
                    ]);
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
