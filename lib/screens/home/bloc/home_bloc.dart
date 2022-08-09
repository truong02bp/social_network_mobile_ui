import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/repositories/user_reporisitory.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  UserRepository userRepository = UserRepository.getInstance();

  HomeBloc() : super(HomeState()) {
    on<FetchDataHomeEvent>((event, emit) async {
      User? user = await userRepository.getUserLogin();
      if (user != null) {
        state.user = user;
        emit(state.clone(HomeStatus.fetchDataSuccess));
      }
    });
  }
}
