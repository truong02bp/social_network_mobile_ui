part of 'following_bloc.dart';

@immutable
abstract class FollowingState {}

class FollowingInitial extends FollowingState {}

class GetFollowingSuccess extends FollowingState {
  List<FollowRelationDto> followRelations;

  GetFollowingSuccess({required this.followRelations});
}

class FollowingLoading extends FollowingState {}

class UnfollowSuccess extends FollowingState {
  final FollowRelationDto followRelationDto;

  UnfollowSuccess({required this.followRelationDto});
}
