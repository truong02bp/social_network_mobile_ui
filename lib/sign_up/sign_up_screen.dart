import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/components/error_snack_bar.dart';
import 'package:social_network_mobile_ui/login/bloc/login_bloc.dart';
import 'package:social_network_mobile_ui/login/bloc/login_state.dart';
import 'package:social_network_mobile_ui/login/login_screen.dart';
import 'package:social_network_mobile_ui/routers.dart';
import 'package:social_network_mobile_ui/sign_up/bloc/sign_up_bloc.dart';
import 'package:social_network_mobile_ui/sign_up/bloc/sign_up_event.dart';
import 'package:social_network_mobile_ui/sign_up/bloc/sign_up_state.dart';
import 'package:social_network_mobile_ui/sign_up/components/sign_up_form.dart';
import 'package:social_network_mobile_ui/sign_up/otp_screen.dart';

class SignUpScreen extends StatelessWidget {
  static final String routeName = '/sign-up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = BlocProvider.of<SignUpBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener(
        bloc: signUpBloc,
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return OtpScreen(signUpBloc, state.email);
            }));
          }
          if (state is SignUpFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar(message: state.message));
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Create your account',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  )),
              const SizedBox(
                height: 50,
              ),
              SignUpForm(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      signUpBloc.add(SubmitEvent());
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red),
                      child: Center(
                          child: const Text(
                        'Sign up',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    onTap: () {
                      pushReplacementLoginScreen(context: context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
