import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/login/bloc/login_bloc.dart';
import 'package:social_network_mobile_ui/login/bloc/login_event.dart';
import 'package:social_network_mobile_ui/constants/theme.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Column(
      children: [
        TextFormField(
          onChanged: (value) {
            loginBloc.add(EmailChangeEvent(email: value));
          },
          decoration: InputDecoration(
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            disabledBorder: outlineInputBorder,
            prefixIcon: Icon(
              Icons.mail_outline,
              size: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Email',
            contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 5),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
            obscureText: true,
            onChanged: (value) {
              loginBloc.add(PasswordChangeEvent(password: value));
            },
            decoration: InputDecoration(
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              errorBorder: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              prefixIcon: Icon(
                Icons.lock,
                size: 16,
              ),
              suffixIcon: Icon(
                Icons.remove_red_eye_outlined,
                size: 16,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Password',
              contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 5),
              labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.6),
              ),
            )),
      ],
    );
  }
}
