import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {
  MessengerBloc() : super(MessengerState()) {
    on<GetConversationEvent>(_getConversation);
  }

  void _getConversation(
      GetConversationEvent event, Emitter<MessengerState> emit) async {

  }
}
