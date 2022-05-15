import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/login/bloc/login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);
  String email = '';
  String password = '';

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    switch (event.runtimeType) {
      case EmailChangeEvent:
        event as EmailChangeEvent;
        email = event.email;
        print(email);
        break;
      case PasswordChangeEvent:
        event as PasswordChangeEvent;
        password = event.password;
        print(password);
        break;
      case SubmitEvent:
        String message = validate(email, password);
        if (message.isEmpty) {
          yield LoginSuccess();
        }
        else {
          yield LoginFailure(message: message);
        }
        break;
    }
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
