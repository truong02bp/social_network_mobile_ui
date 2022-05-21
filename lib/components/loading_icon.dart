import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget {
  final double height;
  final double width;

  LoadingIcon({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/loading.gif"),
              fit: BoxFit.cover)),
    );
  }
}
