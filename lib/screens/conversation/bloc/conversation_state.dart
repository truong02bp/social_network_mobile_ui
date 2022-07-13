part of 'conversation_bloc.dart';

enum ConversationStatus { initial, typing }

class ConversationState {
  Conversation? conversation;
  bool isActive = false;
  String leave = "";
  String name = "";
  bool isTyping = false;
  ConversationStatus status = ConversationStatus.initial;

  ConversationState clone({required ConversationStatus status}) {
    ConversationState state = ConversationState();
    state.conversation = this.conversation;
    state.isActive = this.isActive;
    state.status = status;
    state.leave = this.leave;
    state.name = this.name;
    state.isTyping = this.isTyping;
    return state;
  }
}
