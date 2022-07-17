part of 'messenger_bloc.dart';

enum MessengerStatus { initial, getConversationSuccess, receiveMessage }

class MessengerState {
  User? user;
  List<Conversation> conversations = [];
  Conversation? conversationUpdated;
  int page = 0;
  int limit = 15;
  MessengerStatus status = MessengerStatus.initial;

  MessengerState clone(MessengerStatus status) {
    MessengerState state = MessengerState();
    state.status = status;
    state.conversations = this.conversations;
    state.page = this.page;
    state.limit = this.limit;
    state.user = this.user;
    state.conversationUpdated = this.conversationUpdated;
    return state;
  }
}
