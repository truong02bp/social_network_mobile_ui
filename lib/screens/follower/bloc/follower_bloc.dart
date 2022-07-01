import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_network_mobile_ui/models/dto/follow_relation_dto.dart';
import 'package:social_network_mobile_ui/repositories/follow_repository.dart';

part 'follower_event.dart';
part 'follower_state.dart';

class FollowerBloc extends Bloc<FollowerEvent, FollowerState> {
  FollowRepository followRepository = FollowRepository.getInstance();

  FollowerBloc() : super(FollowerInitial()) {
    on<GetFollowers>((event, emit) async {
      emit(FollowerLoading());
      List<FollowRelationDto> followRelations =
          await followRepository.getFollowers(
              userId: event.userId,
              username: event.username,
              page: event.page,
              size: event.size);
      emit(GetFollowerSuccess(followRelations: followRelations));
    });

    on<CountFollowRequest>((event, emit) async {
      final total =
          await followRepository.countFollowRequest(userId: event.userId);
      if (total != null) {
        emit(CountFollowRequestSuccess(totalRequest: total));
      }
    });

    on<RemoveFollower>((event, emit) async {
      String? message = await followRepository.deleteFollowRelation(
          userId: event.userId, followerId: event.followRelationDto.user.id);
      if (message != null) {
        emit(RemoveFollowerSuccess(followRelationDto: event.followRelationDto));
      }
    });
  }
}
