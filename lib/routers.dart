import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/login/bloc/login_bloc.dart';
import 'screens/login/bloc/login_state.dart';
import 'screens/login/login_screen.dart';

void pushReplacementLoginScreen({context}) {
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) {
      return BlocProvider(
        create: (context) => LoginBloc(LoginState()),
        child: LoginScreen(),
      );
    },
  ));
}
