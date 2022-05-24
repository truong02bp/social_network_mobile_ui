
import 'package:social_network_mobile_ui/models/user.dart';

class LoginState {

}

class LoginFailure extends LoginState {
  String message;

  LoginFailure({required this.message});
}

class LoginSuccess extends LoginState {
    User user;

    LoginSuccess({required this.user});
}
