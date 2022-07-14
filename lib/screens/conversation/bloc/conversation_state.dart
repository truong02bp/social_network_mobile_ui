part of 'conversation_bloc.dart';

enum ConversationStatus {
  initial,
  typing,
  getMessageSuccess,
  sendMessageSuccess,
  sendMessageFailure,
  loading
}

class ConversationState {
  Conversation? conversation;
  List<Message> messages = [];
  bool isActive = false;
  String leave = "";
  String name = "";
  bool isTyping = false;
  int page = 0;
  int limit = 20;
  ConversationStatus status = ConversationStatus.initial;

  ConversationState clone({required ConversationStatus status}) {
    ConversationState state = ConversationState();
    state.conversation = this.conversation;
    state.isActive = this.isActive;
    state.status = status;
    state.leave = this.leave;
    state.name = this.name;
    state.isTyping = this.isTyping;
    state.messages = this.messages;
    state.page = this.page;
    state.limit = this.limit;
    return state;
  }
}
