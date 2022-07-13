part of 'messenger_bloc.dart';

@immutable
abstract class MessengerEvent {}

class MessengerInitialEvent extends MessengerEvent {
  final User user;

  MessengerInitialEvent({required this.user});
}

class GetConversationEvent extends MessengerEvent {}
