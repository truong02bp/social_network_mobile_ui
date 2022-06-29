import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/models/user.dart';

class Header extends StatelessWidget {
  final User? user;

  Header({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.lock,
          color: Colors.white,
        ),
        const SizedBox(
          width: 30,
        ),
        Text(
          '${user?.username}',
          style: TextStyle(fontSize: 18),
        ),
        Spacer(),
      ],
    );
  }
}
