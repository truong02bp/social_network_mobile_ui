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
