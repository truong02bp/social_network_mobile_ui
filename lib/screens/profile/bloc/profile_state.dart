part of 'profile_bloc.dart';

class ProfileState {}

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

class ProfileUpdateUserSuccess extends ProfileState {
  final User user;

  ProfileUpdateUserSuccess({required this.user});
}

class ProfileUpdatePasswordSuccess extends ProfileState {
  final User user;

  ProfileUpdatePasswordSuccess({required this.user});
}

class ProfileUpdateFailure extends ProfileState {}
