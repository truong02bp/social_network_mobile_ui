part of 'follower_bloc.dart';

@immutable
abstract class FollowerEvent {}

class GetFollowers extends FollowerEvent {
  final int userId;
  final int page;
  final int size;
  final String username;

  GetFollowers(
      {required this.userId,
      required this.page,
      required this.size,
      this.username = ''});
}

class CountFollowRequest extends FollowerEvent {
  final int userId;

  CountFollowRequest({required this.userId});
}

class RemoveFollower extends FollowerEvent {
  final FollowRelationDto followRelationDto;
  final int userId;

  RemoveFollower({required this.followRelationDto, required this.userId});
}
