part of 'following_bloc.dart';

@immutable
abstract class FollowingEvent {}

class GetFollowing extends FollowingEvent {
  int page;
  int size;
  int userId;
  String username;

  GetFollowing(
      {required this.page,
      required this.size,
      required this.userId,
      required this.username});
}

class UnfollowEvent extends FollowingEvent {
  final int userId;
  final FollowRelationDto followRelationDto;

  UnfollowEvent({required this.userId, required this.followRelationDto});
}
