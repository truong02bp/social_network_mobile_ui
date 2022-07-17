import 'package:flutter/material.dart';

class DotSend extends StatelessWidget {
  final Color color;

  DotSend({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Image.asset("assets/images/dot.png", color: Colors.black, ),
      ),
    );
  }
}
