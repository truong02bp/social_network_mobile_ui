part of 'post_creation_bloc.dart';

enum PostCreationStatus { initial, changeImageSuccess }

class PostCreationState {
  int currentImage = 0;
  PostCreationStatus status = PostCreationStatus.initial;

  PostCreationState clone(PostCreationStatus status) {
    PostCreationState state = PostCreationState();
    state.status = status;
    state.currentImage = this.currentImage;
    return state;
  }
}
