import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/sign_up/bloc/sign_up_event.dart';
import 'package:social_network_mobile_ui/screens/sign_up/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState());

  String phone = '';
  String name = '';
  String email = '';
  String password = '';

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    switch (event.runtimeType) {
      case ChangeNameEvent:
        event as ChangeNameEvent;
        name = event.name;
        break;
      case ChangePhoneEvent:
        event as ChangePhoneEvent;
        phone = event.phone;
        break;
      case ChangeEmailEvent:
        event as ChangeEmailEvent;
        email = event.email;
        break;
      case ChangePasswordEvent:
        event as ChangePasswordEvent;
        password = event.password;
        break;
      case SubmitEvent:
        String message = validate(email, password);
        if (message.isEmpty) {
          yield SignUpSuccess(email: email);
        }
        else {
          yield SignUpFailure(message: message);
        }
        break;
    }
  }

  String validate(String email, String password) {
    if (name.isEmpty) {
      return "Name must be not empty";
    }
    if (phone.isEmpty) {
      return "Phone must be not empty";
    }
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
