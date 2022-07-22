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
  List<File> medias = [];
  List<File> mediasSelected = [];
  Set<String> sources = Set();
  String sourceSelected = 'All';
  ScrollController _scrollController = ScrollController();
  int page = 0;
  int size = 20;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    sources.add(sourceSelected);
    _galleryBloc = BlocProvider.of<GalleryBloc>(context);
    _galleryBloc.add(GalleryGetSources());
    _galleryBloc.add(GalleryGetFromSource(
        page: 0, size: size, type: type, source: sourceSelected));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _galleryBloc.add(GalleryGetFromSource(
            page: page + 1, size: size, type: type, source: sourceSelected));
        page += 1;
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
                  BlocBuilder(
                    bloc: _galleryBloc,
                    builder: (BuildContext context, state) {
                      if (state is GalleryGetSourcesSuccess) {
                        sources.addAll(state.sources);
                      }
                      return DropdownButton(
                        value: sourceSelected,
                        onChanged: (value) {
                          sourceSelected = value as String;
                          page = 0;
                          medias.clear();
                          _galleryBloc.add(GalleryGetFromSource(
                              page: 0,
                              size: size,
                              type: type,
                              source: sourceSelected));
                        },
                        items: sources
                            .map((source) => DropdownMenuItem(
                                value: source, child: Text('$source')))
                            .toList(),
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder(
                  bloc: _galleryBloc,
                  buildWhen: (previous, current) =>
                      current is GalleryGetFromSourceSuccess,
                  builder: (BuildContext context, state) {
                    if (state is GalleryGetFromSourceSuccess) {
                      medias.addAll(state.medias);
                    }
                    return Container(
                      child: GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          shrinkWrap: true,
                          itemCount: medias.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                process(medias[index], context);
                              },
                              child: Container(
                                key: ValueKey(medias[index].path),
                                margin: EdgeInsets.only(left: 3, bottom: 3),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(medias[index]),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          }),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              BlocBuilder(
                  bloc: _galleryBloc,
                  builder: (context, state) {
                    if (state is Loading) {
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

  void process(File file, BuildContext context) {
    if (option == 'single') {
      mediasSelected = [file];
      callBackSingle!(mediasSelected[0]);
    } else if (option == 'multi') {
      callBackMulti!(mediasSelected);
    }
    Navigator.pop(context);
  }
}
