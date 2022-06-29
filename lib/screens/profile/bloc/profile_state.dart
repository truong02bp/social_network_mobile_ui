part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetUserSuccess extends ProfileState {

    final User user;

    GetUserSuccess({required this.user});
}

class GetProfileSuccess extends ProfileState {
    final ProfileDto profileDto;

    GetProfileSuccess({required this.profileDto});
}

class ProfileUpdateAvatarSuccess extends ProfileState {
    final User user;

    ProfileUpdateAvatarSuccess({required this.user});
}
