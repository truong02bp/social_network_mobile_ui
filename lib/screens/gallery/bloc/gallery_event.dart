part of 'gallery_bloc.dart';

@immutable
abstract class GalleryEvent {}

class GalleryGetFromSource extends GalleryEvent {
  int page;
  int size;
  String source;
  String type;
  GalleryGetFromSource({required this.page, required this.size, required this.source, required this.type});
}

class GalleryGetSources extends GalleryEvent {

}