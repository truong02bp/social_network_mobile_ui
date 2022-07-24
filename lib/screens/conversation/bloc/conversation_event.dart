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

class SendImageMessageEvent extends ConversationEvent {
  final Set<File> images;

  SendImageMessageEvent({required this.images});
}

class ReceiveMessageEvent extends ConversationEvent {
  final Message message;

  ReceiveMessageEvent({required this.message});
}

class GetMessageEvent extends ConversationEvent {}

class UpdateSeenMessageEvent extends ConversationEvent {
  final List<Message> messages;

  UpdateSeenMessageEvent({required this.messages});
}

class UpdateMessageReactionEvent extends ConversationEvent {
  final Message message;

  UpdateMessageReactionEvent({required this.message});
}

class UpdateMessageEvent extends ConversationEvent {
  final String type;
  final String? value;
  final int? messageId;

  UpdateMessageEvent({required this.type, this.value, this.messageId});
}
