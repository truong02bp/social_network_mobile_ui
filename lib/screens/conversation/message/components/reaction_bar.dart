import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/components/custom_icon.dart';

class ReactionBar extends StatelessWidget {
  final Function callBack;

  ReactionBar({required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 240,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildIcon(context, "heart"),
              buildIcon(context, "haha"),
              buildIcon(context, "wow"),
              buildIcon(context, "sad"),
              buildIcon(context, "angry"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIcon(BuildContext context, String value) {
    return CustomIcon(
        image: "assets/images/$value.png",
        onTap: () {
          callBack(value);
          Navigator.pop(context);
        });
  }
}
