import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_network_mobile_ui/models/dto/follow_relation_dto.dart';
import 'package:social_network_mobile_ui/repositories/follow_repository.dart';

part 'following_event.dart';
part 'following_state.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  FollowRepository followRepository = FollowRepository.getInstance();

  FollowingBloc() : super(FollowingInitial()) {
    on<GetFollowing>((event, emit) async {
      emit(FollowingLoading());
      List<FollowRelationDto> followRelations =
          await followRepository.getFollowing(
              userId: event.userId,
              username: event.username,
              page: event.page,
              size: event.size);
      emit(GetFollowingSuccess(followRelations: followRelations));
    });

    on<UnfollowEvent>((event, emit) async {
      String? message = await followRepository.deleteFollowRelation(
          userId: event.followRelationDto.user.id, followerId: event.userId);
      if (message != null) {
        emit(UnfollowSuccess(followRelationDto: event.followRelationDto));
      }
    });
  }
}
