import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/models/user.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Text('${user.name}'),
        ),
      ),
    );
  }
}
