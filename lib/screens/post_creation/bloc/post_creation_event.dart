part of 'post_creation_bloc.dart';

@immutable
abstract class PostCreationEvent {}

class ChangeImage extends PostCreationEvent {
  final int index;

  ChangeImage({required this.index});
}
