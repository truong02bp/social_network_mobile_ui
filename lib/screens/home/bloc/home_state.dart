part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class FetchDataHomeState extends HomeState {
  final User user;

  FetchDataHomeState({required this.user});
}
