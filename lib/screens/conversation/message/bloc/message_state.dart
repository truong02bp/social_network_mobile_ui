part of 'message_bloc.dart';

enum MessageStatus { initial }

class MessageState {
  Message? message;
  Conversation? conversation;
  bool showDate = true;
  bool needMessageStatus = false;
  bool isSender = false;
  late Color color;
  MessageStatus status = MessageStatus.initial;

  MessageState clone({required MessageStatus status}) {
    MessageState state = MessageState();
    state.status = status;
    state.message = this.message;
    state.showDate = this.showDate;
    state.needMessageStatus = this.needMessageStatus;
    state.conversation = this.conversation;
    state.isSender = this.isSender;
    state.color = this.color;
    return state;
  }
}
