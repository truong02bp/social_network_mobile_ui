import 'package:flutter/material.dart';

class DotSeen extends StatelessWidget {
  final String url;

  DotSeen(this.url);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 8,
      backgroundImage: NetworkImage(url),
    );
  }
}
