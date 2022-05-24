import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/login/bloc/login_bloc.dart';
import 'package:social_network_mobile_ui/screens/login/bloc/login_event.dart';
import 'package:social_network_mobile_ui/screens/login/bloc/login_state.dart';
import 'package:social_network_mobile_ui/screens/login/login_screen.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'constants/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isLightTheme = false;
    return KeyboardDismisser(
      gestures: [GestureType.onTap, GestureType.onTapCancel],
      child: MaterialApp(
        title: 'Social Network',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: isLightTheme ? Colors.grey : Colors.grey,
          primaryColor: isLightTheme ? Colors.white : AppColor.black3,
          brightness: isLightTheme ? Brightness.light : Brightness.dark,
          backgroundColor: isLightTheme ? Color(0xFFFFFFFF) : AppColor.black3,
          scaffoldBackgroundColor:
              isLightTheme ? Color(0xFFFFFFFF) : AppColor.black3,
        ),
        home: BlocProvider(
            create: (context) => LoginBloc(LoginState())..add(CheckLoginEvent()),
            child: LoginScreen()),
      ),
    );
  }
}
