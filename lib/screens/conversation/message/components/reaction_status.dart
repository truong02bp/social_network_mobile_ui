import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/components/custom_icon.dart';

class ReactionStatus extends StatelessWidget {
  final Map<String, List<String>> reactionDetails;

  ReactionStatus(this.reactionDetails);

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    List<Container> reactions = [];
    reactionDetails.forEach((key, value) {
      counter += value.length;
      reactions.add(Container(
        child: CustomIcon(
          image: "assets/images/$key.png",
          height: 16,
          width: 16,
        ),
      ));
    });
    if (counter > 1) {
      reactions.add(Container(
        margin: EdgeInsets.only(left: 4),
        child: Text("$counter"),
      ));
    }
    return InkWell(
      onTap: () {},
      child: Container(
        width: (16 * reactions.length).toDouble(),
        height: 18,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          children: reactions,
        ),
      ),
    );
  }
}
