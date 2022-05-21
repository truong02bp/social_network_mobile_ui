
class SignUpEvent {

}

class ChangeNameEvent extends SignUpEvent {
  String name;

  ChangeNameEvent({required this.name});
}

class ChangePhoneEvent extends SignUpEvent {
  String phone;

  ChangePhoneEvent({required this.phone});
}

class ChangeEmailEvent extends SignUpEvent {
  String email;

  ChangeEmailEvent({required this.email});
}

class ChangePasswordEvent extends SignUpEvent {
  String password;

  ChangePasswordEvent({required this.password});
}

class SubmitEvent extends SignUpEvent {

}

class SendOtpEvent extends SignUpEvent {

}

class ConfirmOtpEvent extends SignUpEvent {
  String otp;

  ConfirmOtpEvent({required this.otp});
}

