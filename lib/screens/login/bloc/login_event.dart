
class LoginEvent {

}

class EmailChangeEvent extends LoginEvent {
  final String email;

  EmailChangeEvent({required this.email});
}

class PasswordChangeEvent extends LoginEvent {
  final String password;

  PasswordChangeEvent({required this.password});
}

class SubmitEvent extends LoginEvent {

}

class CheckLoginEvent extends LoginEvent {

}