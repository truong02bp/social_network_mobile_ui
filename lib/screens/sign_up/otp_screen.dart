import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_network_mobile_ui/constants/theme.dart';
import 'package:social_network_mobile_ui/screens/sign_up/bloc/sign_up_bloc.dart';

class OtpScreen extends StatelessWidget {
  final SignUpBloc signUpBloc;
  final String email;

  OtpScreen(this.signUpBloc, this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verification code',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('We have sent the code verification to $email!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                )),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildField(
                    context: context,
                    onChange: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    }),
                Spacer(),
                buildField(
                    context: context,
                    onChange: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    }),
                Spacer(),
                buildField(
                    context: context,
                    onChange: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    }),
                Spacer(),
                buildField(
                    context: context,
                    onChange: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    }),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    child: Center(
                        child: const Text(
                      'Confirm',
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Didn\'t receive verification code?'),
                const SizedBox(
                  width: 25,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Resend',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox buildField({context, onChange}) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        onChanged: onChange,
        decoration: InputDecoration(
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
