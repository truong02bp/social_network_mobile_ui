part of 'gallery_bloc.dart';

enum GalleryStatus {
  initial,
  getFromSourceSuccess,
  getSourcesSuccess,
  loading,
  selectFileSuccess,
  previewFileSuccess,
  stopPreviewFileSuccess
}

class GalleryState {
  Set<String> sources = Set();
  List<File> medias = [];
  Set<File> mediasSelected = Set();
  File? previewFile;
  String sourceSelected = 'All';
  String type = 'image';
  GalleryStatus status = GalleryStatus.initial;
  int page = 0;
  int size = 20;

  GalleryState clone(GalleryStatus status) {
    GalleryState state = GalleryState();
    state.medias = this.medias;
    state.sourceSelected = this.sourceSelected;
    state.sources = this.sources;
    state.mediasSelected = this.mediasSelected;
    state.page = this.page;
    state.size = this.size;
    state.status = status;
    state.type = this.type;
    state.previewFile = this.previewFile;
    return state;
  }
}
