import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/login/bloc/login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String email = '';
  String password = '';

  LoginBloc(LoginState initialState) : super(initialState) {
    on<EmailChangeEvent>((event, emit) {
      email = event.email;
      print(email);
    });

    on<PasswordChangeEvent>((event, emit) {
      password = event.password;
      print(password);
    });

    on<SubmitEvent>((event, emit) {
      String message = validate(email, password);
      if (message.isEmpty) {
        emit(LoginSuccess());
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
