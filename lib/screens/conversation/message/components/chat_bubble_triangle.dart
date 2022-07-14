import 'package:flutter/material.dart';

class ChatBubbleTriangle extends CustomPainter {

  final Color color;
  final bool isSender;


  ChatBubbleTriangle({required this.color, required this.isSender});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    Path paintBubbleTail() {
      Path path;
      if (!isSender) {
        path = Path()
          ..moveTo(5, size.height - 4)
          ..quadraticBezierTo(-5, size.height, -10, size.height - 10)
          ..quadraticBezierTo(-5, size.height, 0, size.height - 12);
      }
      else {
        path = Path()
          ..moveTo(size.width - 3, size.height - 5)
          ..quadraticBezierTo(
              size.width + 5, size.height, size.width + 12, size.height - 10)
          ..quadraticBezierTo(
              size.width + 5, size.height , size.width, size.height - 12);
      }
      return path;
    }

    final RRect bubbleBody = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(16));
    final Path bubbleTail = paintBubbleTail();

    canvas.drawRRect(bubbleBody, paint);
    canvas.drawPath(bubbleTail, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}