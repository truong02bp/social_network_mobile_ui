import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_mobile_ui/models/dto/follow_relation_dto.dart';
import 'package:social_network_mobile_ui/models/dto/media_dto.dart';
import 'package:social_network_mobile_ui/models/dto/profile_dto.dart';
import 'package:social_network_mobile_ui/models/dto/user_dto.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/repositories/follow_repository.dart';
import 'package:social_network_mobile_ui/repositories/user_reporisitory.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository userRepository = UserRepository.getInstance();
  FollowRepository followRepository = FollowRepository.getInstance();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>((event, emit) async {
      User? user = await userRepository.getUserLogin();
      if (user != null) {
        emit(GetUserSuccess(user: user));
      }
      ProfileDto? profile =
          await userRepository.getProfileInformation(userId: user?.id);
      if (profile != null) {
        emit(GetProfileSuccess(profileDto: profile));
      }
    });

    on<ProfileUpdateAvatar>((event, emit) async {
      MediaDto mediaDto = new MediaDto(
          name: event.name, bytes: event.bytes, userId: event.userId);
      User? user = await userRepository.updateAvatar(mediaDto: mediaDto);
      if (user != null) {
        emit(ProfileUpdateAvatarSuccess(user: user));
      } else {
        emit(ProfileUpdateFailure());
      }
    });

    on<ProfileLogout>((event, emit) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.clear();
    });

    on<ProfileUpdateUser>((event, emit) async {
      String? message = await userRepository.update(user: event.user);
      if (message != null) {
        emit(ProfileUpdateUserSuccess(user: event.user));
      } else {
        emit(ProfileUpdateFailure());
      }
    });

    on<ProfileUpdatePassword>((event, emit) async {
      UserDto userDto = new UserDto(
          id: event.userId,
          oldPassword: event.oldPassword,
          newPassword: event.newPassword);
      User? user = await userRepository.updatePassword(userDto: userDto);
      if (user != null) {
        emit(ProfileUpdatePasswordSuccess(user: user));
      } else {
        emit(ProfileUpdateFailure());
      }
    });

    on<ProfileGetFollowers>((event, emit) async {
      emit(ProfileLoading());
      List<FollowRelationDto> followRelations =
          await followRepository.getFollowers(
              userId: event.userId,
              username: event.username,
              page: event.page,
              size: event.size);
      emit(ProfileGetFollowerSuccess(followRelations: followRelations));
    });
  }
}
