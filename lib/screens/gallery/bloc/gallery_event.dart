part of 'gallery_bloc.dart';

@immutable
abstract class GalleryEvent {}

class GalleryInitialEvent extends GalleryEvent {
  String type;

  GalleryInitialEvent({required this.type});
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

class GalleryGetSources extends GalleryEvent {}
