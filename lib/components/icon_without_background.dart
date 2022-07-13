import 'package:flutter/material.dart';
class IconWithoutBackground extends StatelessWidget {

  final String image;
  final double height;
  final double width;
  final Color? color;
  final Function()? onTap;

  IconWithoutBackground(
      {required this.image, required this.height, this.color,  this.onTap, required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ,
      child: Container(
          height: height,
          width: width,
          child: Image.asset("$image", color: color,)
      ),
    );
  }
}
