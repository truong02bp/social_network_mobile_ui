part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class MessageInitialEvent extends MessageEvent {
  final Conversation conversation;
  final Message message;

  MessageInitialEvent({required this.conversation, required this.message});
}
