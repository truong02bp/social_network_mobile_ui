import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/bloc/login_bloc.dart';
import 'login/bloc/login_state.dart';
import 'login/login_screen.dart';

void pushReplacementLoginScreen({context}){
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) {
      return BlocProvider(
        create: (context) => LoginBloc(LoginState()),
        child: LoginScreen(),
      );
    },
  ));
}