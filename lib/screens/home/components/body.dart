import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/home/components/post_list.dart';
import 'package:social_network_mobile_ui/screens/home/components/story_bar.dart';

class Body extends StatelessWidget {
  final User user;

  Body(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [StoryBar(user), Expanded(child: PostList(user))],
    );
  }
}
