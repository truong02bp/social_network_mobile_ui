import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_creation_event.dart';
part 'post_creation_state.dart';

class PostCreationBloc extends Bloc<PostCreationEvent, PostCreationState> {
  PostCreationBloc() : super(PostCreationInitial()) {
    on<PostCreationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
