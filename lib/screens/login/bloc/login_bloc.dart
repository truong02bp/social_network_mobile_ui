import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/repositories/user_reporisitory.dart';
import 'package:social_network_mobile_ui/screens/login/bloc/login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String email = '';
  String password = '';
  UserRepository userRepository = UserRepository.getInstance();

  LoginBloc(LoginState initialState) : super(initialState) {
    on<CheckLoginEvent>((event, emit) async {
      User? user = await userRepository.getUserLogin();
      if (user != null) {
        emit(LoginSuccess());
      }
    });

    on<EmailChangeEvent>((event, emit) {
      email = event.email;
    });

    on<PasswordChangeEvent>((event, emit) {
      password = event.password;
    });

    on<SubmitEvent>((event, emit) async {
      String message = validate(email, password);
      if (message.isEmpty) {
        String? user = await userRepository.login(email: email, password: password);
        if (user != null) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(message: message));
        }
      } else {
        emit(LoginFailure(message: message));
      }
    });
  }

  String validate(String email, String password) {
    if (email.isEmpty) {
      return "Email must be not empty";
    }
    if (!email.contains("@gmail.com")) {
      return "Email must contain @gmail.com";
    }
    if (password.isEmpty) {
      return "Password must be not empty";
    }
    return "";
  }
}
