import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {
  MessengerBloc() : super(MessengerState()) {
    _onGetConversationEvent();
  }

  void _onGetConversationEvent() async {
    on<GetConversationEvent>((event, emit) =>
    {
    });
  }
}
