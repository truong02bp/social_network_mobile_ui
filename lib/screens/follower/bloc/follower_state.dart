part of 'follower_bloc.dart';

@immutable
abstract class FollowerState {}

class FollowerInitial extends FollowerState {}

class GetFollowerSuccess extends FollowerState {
  final List<FollowRelationDto> followRelations;

  GetFollowerSuccess({required this.followRelations});
}

class FollowerLoading extends FollowerState {}

class CountFollowRequestSuccess extends FollowerState {
  final int totalRequest;

  CountFollowRequestSuccess({required this.totalRequest});
}

class RemoveFollowerSuccess extends FollowerState {
  final FollowRelationDto followRelationDto;

  RemoveFollowerSuccess({required this.followRelationDto});
}
