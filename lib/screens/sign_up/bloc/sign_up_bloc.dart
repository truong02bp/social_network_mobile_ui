import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/sign_up/bloc/sign_up_event.dart';
import 'package:social_network_mobile_ui/screens/sign_up/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  String phone = '';
  String name = '';
  String email = '';
  String password = '';

  SignUpBloc() : super(SignUpState()) {
    on<ChangeNameEvent>((event, emit) {
      name = event.name;
    });

    on<ChangePhoneEvent>((event, emit) {
      phone = event.phone;
    });

    on<ChangeEmailEvent>((event, emit) {
      email = event.email;
    });

    on<ChangePasswordEvent>((event, emit) {
      password = event.password;
    });

    on<SubmitEvent>((event, emit) {
      String message = validate(email, password);
      if (message.isEmpty) {
        emit(SignUpSuccess(email: email));
      } else {
        emit(SignUpFailure(message: message));
      }
    });
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
