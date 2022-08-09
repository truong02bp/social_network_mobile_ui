part of 'home_bloc.dart';

enum HomeStatus { initial, fetchDataSuccess }

class HomeState {
  HomeStatus status = HomeStatus.initial;
  User? user;

  HomeState clone(HomeStatus status) {
    HomeState state = HomeState();
    state.status = status;
    state.user = this.user;
    return state;
  }
}
