

class LoginState {

}

class LoginFailure extends LoginState {
  String message;

  LoginFailure({required this.message});
}

class LoginSuccess extends LoginState {

}
