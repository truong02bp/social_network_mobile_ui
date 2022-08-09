import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/messenger/messenger_screen.dart';

class Header extends StatelessWidget {
  final User user;

  Header({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Instagram',
          style: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
            height: 20,
            width: 20,
            child: SvgPicture.asset(
              "assets/svgs/add.svg",
              semanticsLabel: 'Acme Logo',
              color: Colors.white,
            )),
        const SizedBox(
          width: 25,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MessengerScreen(user);
            }));
          },
          child: Container(
              height: 25,
              width: 25,
              child: SvgPicture.asset(
                "assets/svgs/message.svg",
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
