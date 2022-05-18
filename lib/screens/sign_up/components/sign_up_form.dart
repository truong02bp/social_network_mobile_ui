import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_network_mobile_ui/constants/theme.dart';
import 'package:social_network_mobile_ui/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/sign_up/bloc/sign_up_event.dart';
class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = BlocProvider.of<SignUpBloc>(context);
    return Column(
      children: [
        TextFormField(
          onChanged: (value) {
            signUpBloc.add(ChangeNameEvent(name: value));
          },
          decoration: InputDecoration(
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            disabledBorder: outlineInputBorder,
            prefixIcon: Icon(
              Icons.person,
              size: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Name',
            contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 5),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          onChanged: (value) {
            signUpBloc.add(ChangePhoneEvent(phone: value));
          },
          decoration: InputDecoration(
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            disabledBorder: outlineInputBorder,
            prefixIcon: Icon(
              Icons.phone,
              size: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Phone',
            contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 5),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          onChanged: (value) {
            signUpBloc.add(ChangeEmailEvent(email: value));
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
          height: 15,
        ),
        TextFormField(
            obscureText: true,
            onChanged: (value) {
              signUpBloc.add(ChangePasswordEvent(password: value));
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
