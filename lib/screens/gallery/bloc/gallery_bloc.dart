import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryInitial()) {
    on<GalleryGetSources>((event, emit) async {
      List<AssetPathEntity> paths =
          await PhotoManager.getAssetPathList(type: RequestType.common);
      List<String> sources = paths.map((e) => e.name).toList();
      emit(GalleryGetSourcesSuccess(sources: sources));
    });

    on<GalleryGetFromSource>((event, emit) async {
      emit(Loading());
      List<AssetPathEntity> paths = [];
      switch (event.type) {
        case 'image':
          paths = await PhotoManager.getAssetPathList(
              type: RequestType.image);
          break;
        case 'video':
          paths = await PhotoManager.getAssetPathList(
              type: RequestType.video);
          break;
        case 'all':
          paths = await PhotoManager.getAssetPathList(
              type: RequestType.video);
          break;
      }
      for (AssetPathEntity path in paths) {
        if (path.name == event.source) {
          List<AssetEntity> assets = await path.getAssetListPaged(page: event.page, size: event.size);
          List<File> images = [];
          for (AssetEntity asset in assets) {
            File? image = await asset.file;
            if (image != null) {
              images.add(image);
            }
          }
          emit(GalleryGetFromSourceSuccess(medias: images));
          break;
        }
      }
    });
  }
}
