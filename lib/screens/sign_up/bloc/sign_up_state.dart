class SignUpState {}

class Loading extends SignUpState {

}

class OtpSent extends SignUpState {
  final String email;

  OtpSent({required this.email});
}

class SignUpSuccess extends SignUpState {

}

class SignUpFailure extends SignUpState {
  String message;

  SignUpFailure({required this.message});
}

class OtpWrong extends SignUpState {

}
