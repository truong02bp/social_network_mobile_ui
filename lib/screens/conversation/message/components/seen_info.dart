import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/models/message_interaction.dart';

class SeenInfo extends StatelessWidget {
  final bool isSender;
  final List<MessageInteraction>? interactions;

  SeenInfo({required this.isSender, this.interactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      // child: Row(
      //   mainAxisAlignment:
      //       isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      //   children: [
      //     interactios != null
      //         ? Text('Seen at ${formatDate(time: interaction!.createdDate)}')
      //         : Text('Sent'),
      //   ],
      // ),
    );
  }
}
