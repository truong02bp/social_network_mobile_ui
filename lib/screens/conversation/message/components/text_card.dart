import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  final String? text;
  final Color? color;

  TextCard({required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: new BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 2 / 3),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
      child: Text('$text',
          style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.9))),
    );
  }
}
