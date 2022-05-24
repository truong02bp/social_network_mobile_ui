import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_network_event.dart';
part 'video_network_state.dart';

class VideoNetworkBloc extends Bloc<VideoNetworkEvent, VideoNetworkState> {
  VideoNetworkBloc() : super(VideoNetworkInitial()) {
    on<VideoNetworkEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
