part of 'gallery_bloc.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class Loading extends GalleryState {

}

class GalleryGetFromSourceSuccess extends GalleryState {
  List<File> medias;

  GalleryGetFromSourceSuccess({required this.medias});
}

class GalleryGetSourcesSuccess extends GalleryState {
  List<String> sources;

  GalleryGetSourcesSuccess({required this.sources});
}