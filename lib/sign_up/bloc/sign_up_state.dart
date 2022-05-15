class SignUpState {}

class SignUpSuccess extends SignUpState {
  final String email;

  SignUpSuccess({required this.email});
}

class SignUpFailure extends SignUpState {
  String message;

  SignUpFailure({required this.message});
}
