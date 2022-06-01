abstract class MessengerEvent {}

class GetConversationEvent extends MessengerEvent {
  int userId;
  int page;
  int limit;

  GetConversationEvent({required this.userId, required this.page, required this.limit});
}