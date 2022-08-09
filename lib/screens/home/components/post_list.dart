import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/models/user.dart';

class PostList extends StatelessWidget {
  final User user;

  PostList(this.user);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [],
          );
        });
  }
}
