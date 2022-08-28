import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryState()) {
    _onInitialEvent();
    _onGetFromSourceEvent();
    _onUpdateSelectedSourceEvent();
    _onSelectFileEvent();
    _onPreviewFileEvent();
    _onStopPreviewFileEvent();
  }

  _onStopPreviewFileEvent() {
    on<StopPreviewFileEvent>((event, emit) {
      state.previewFile = null;
      emit(state.clone(GalleryStatus.stopPreviewFileSuccess));
    });
  }

  _onPreviewFileEvent() {
    on<PreviewFileEvent>((event, emit) {
      state.previewFile = event.file;
      emit(state.clone(GalleryStatus.previewFileSuccess));
    });
  }

  _onSelectFileEvent() {
    on<SelectFileEvent>((event, emit) {
      if (state.mediasSelected.contains(event.file)) {
        state.mediasSelected.remove(event.file);
      } else {
        if (state.previewMedia) {
          state.previewMediaFile = event.file;
        }
        state.mediasSelected.add(event.file);
      }
      emit(state.clone(GalleryStatus.selectFileSuccess));
    });
  }

  _onUpdateSelectedSourceEvent() {
    on<UpdateSourceSelected>((event, emit) {
      state.sourceSelected = event.sourceSelected;
      state.page = 0;
      state.medias.clear();
      state.mediasSelected.clear();
      add(GalleryGetFromSource());
    });
  }

  _onGetFromSourceEvent() {
    on<GalleryGetFromSource>((event, emit) async {
      emit(state.clone(GalleryStatus.loading));

      List<AssetPathEntity> paths = [];
      switch (state.type) {
        case 'image':
          paths = await PhotoManager.getAssetPathList(type: RequestType.image);
          break;
        case 'video':
          paths = await PhotoManager.getAssetPathList(type: RequestType.video);
          break;
        case 'all':
          paths = await PhotoManager.getAssetPathList(type: RequestType.common);
          break;
      }
      int page = state.page;
      int size = state.size;
      String source = state.sourceSelected;
      if (source == 'All') {
        List<File> images = [];
        for (AssetPathEntity path in paths) {
          List<AssetEntity> assets =
              await path.getAssetListPaged(page: page, size: size);
          for (AssetEntity asset in assets) {
            File? image = await asset.file;
            if (image != null) {
              images.add(image);
            }
          }
        }
        state.medias.addAll(images);
        emit(state.clone(GalleryStatus.getFromSourceSuccess));
      } else {
        for (AssetPathEntity path in paths) {
          if (path.name == source) {
            List<AssetEntity> assets =
                await path.getAssetListPaged(page: page, size: size);
            List<File> images = [];
            for (AssetEntity asset in assets) {
              File? image = await asset.file;
              if (image != null) {
                images.add(image);
              }
            }
            state.medias.addAll(images);
            emit(state.clone(GalleryStatus.getFromSourceSuccess));
            break;
          }
        }
      }
      state.page++;
      if (state.previewMediaFile == null &&
          state.previewMedia &&
          state.medias.isNotEmpty) {
        state.previewMediaFile = state.medias[0];
        emit(state.clone(GalleryStatus.initial));
      }
    });
  }

  _onInitialEvent() {
    on<GalleryInitialEvent>((event, emit) async {
      state.previewMedia = event.previewMedia;
      state.sources.add(state.sourceSelected);
      state.page = 0;
      state.type = event.type;
      List<AssetPathEntity> paths =
          await PhotoManager.getAssetPathList(type: RequestType.common);
      List<String> sources = paths.map((e) => e.name).toList();
      state.sources.addAll(sources);
      emit(state.clone(GalleryStatus.initial));
      add(GalleryGetFromSource());
    });
  }
}
