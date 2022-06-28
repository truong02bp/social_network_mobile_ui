part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {

}

class ProfileLogout extends ProfileEvent {

}
