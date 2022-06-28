
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_mobile_ui/models/dto/profile_dto.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/repositories/user_reporisitory.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile_edit.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  UserRepository userRepository = UserRepository.getInstance();

  ProfileBloc() : super(ProfileInitial()) {

    on<ProfileInitialEvent>((event, emit) async {
        User? user = await userRepository.getUserLogin();
        if (user != null) {
          emit(GetUserSuccess(user: user));
        }
        ProfileDto? profile = await userRepository.getProfileInformation(userId: user?.id);
        if (profile != null) {
          emit(GetProfileSuccess(profileDto: profile));
        }
    });

    on<ProfileLogout>((event, emit) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();
    });
  }
}
