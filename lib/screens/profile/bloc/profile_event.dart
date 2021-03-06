part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {}

class ProfileLogout extends ProfileEvent {}

class ProfileUpdateAvatar extends ProfileEvent {
  final int userId;
  final String bytes;
  final String name;

  ProfileUpdateAvatar(
      {required this.userId, required this.bytes, required this.name});
}

class ProfileUpdateUser extends ProfileEvent {
  final User user;

  ProfileUpdateUser({required this.user});
}

class ProfileUpdatePassword extends ProfileEvent {
  final int userId;
  final String oldPassword;
  final String newPassword;

  ProfileUpdatePassword(
      {required this.userId,
      required this.oldPassword,
      required this.newPassword});
}
