import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_creation_event.dart';
part 'post_creation_state.dart';

class PostCreationBloc extends Bloc<PostCreationEvent, PostCreationState> {
  PostCreationBloc() : super(PostCreationState()) {
    on<ChangeImage>((event, emit) {
      print(event.index);
      state.currentImage = event.index;
      emit(state.clone(PostCreationStatus.changeImageSuccess));
    });
  }
}
