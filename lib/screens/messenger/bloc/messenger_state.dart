part of 'messenger_bloc.dart';

enum MessengerStatus { initial, getConversationSuccess }

class MessengerState {
  User? user;
  List<Conversation> conversations = [];
  int page = 0;
  int limit = 15;
  MessengerStatus status = MessengerStatus.initial;

  MessengerState clone(MessengerStatus status) {
    MessengerState state = MessengerState();
    state.status = status;
    state.conversations = this.conversations;
    state.page = this.page;
    state.limit = this.limit;
    return state;
  }
}
