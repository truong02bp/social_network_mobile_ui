part of 'gallery_bloc.dart';

@immutable
abstract class GalleryEvent {}

class GalleryInitialEvent extends GalleryEvent {
  String type;
  bool previewMedia;

  GalleryInitialEvent({required this.type, required this.previewMedia});
}

class GalleryGetFromSource extends GalleryEvent {}

class UpdateSourceSelected extends GalleryEvent {
  final String sourceSelected;

  UpdateSourceSelected({required this.sourceSelected});
}

class SelectFileEvent extends GalleryEvent {
  final File file;

  SelectFileEvent({required this.file});
}

class PreviewFileEvent extends GalleryEvent {
  final File file;

  PreviewFileEvent({required this.file});
}

class StopPreviewFileEvent extends GalleryEvent {}

class GalleryGetSources extends GalleryEvent {}
