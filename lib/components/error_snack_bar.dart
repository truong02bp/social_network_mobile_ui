import 'package:flutter/material.dart';

SnackBar errorSnackBar({required String message}) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: EdgeInsets.all(16),
        height: 90,
        decoration: BoxDecoration(
            color: Color(0xFFC72C41),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Oh snap!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    "$message!",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

          ],
        ),
      ));
}
