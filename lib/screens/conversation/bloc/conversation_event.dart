part of 'conversation_bloc.dart';

@immutable
abstract class ConversationEvent {}

class ConversationInitialEvent extends ConversationEvent {
  final Conversation conversation;

  ConversationInitialEvent({required this.conversation});
}

class ConversationTypingEvent extends ConversationEvent {
  final bool isTyping;

  ConversationTypingEvent({required this.isTyping});
}

class SendTextMessageEvent extends ConversationEvent {
  final String content;

  SendTextMessageEvent({required this.content});
}

class ReceiveMessageEvent extends ConversationEvent {
  final Message message;

  ReceiveMessageEvent({required this.message});
}

class GetMessageEvent extends ConversationEvent {}
