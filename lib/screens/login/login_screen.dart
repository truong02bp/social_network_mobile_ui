import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/components/error_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/home/home_screen.dart';
import 'package:social_network_mobile_ui/screens/login/bloc/login_bloc.dart';
import 'package:social_network_mobile_ui/screens/login/bloc/login_event.dart';
import 'package:social_network_mobile_ui/screens/login/bloc/login_state.dart';
import 'package:social_network_mobile_ui/screens/login/components/form_login.dart';
import 'package:social_network_mobile_ui/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:social_network_mobile_ui/screens/sign_up/sign_up_screen.dart';
import 'package:social_network_mobile_ui/size_config.dart';

class LoginScreen extends StatelessWidget {
  static final String routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener(
          bloc: loginBloc,
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(errorSnackBar(message: state.message));
            }
            if (state is LoginSuccess) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return HomeScreen(user: state.user);
              }));
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Please sign in to continue',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    )),
                const SizedBox(
                  height: 50,
                ),
                FormLogin(),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        loginBloc.add(SubmitEvent());
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red),
                        child: Center(
                            child: const Text(
                          'Login',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
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
                    const Text('Don\'t have an account ?'),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BlocProvider(
                            create: (context) => SignUpBloc(),
                            child: SignUpScreen(),
                          );
                        }));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
