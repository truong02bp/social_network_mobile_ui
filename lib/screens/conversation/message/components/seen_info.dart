import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/models/message_interaction.dart';
import 'package:social_network_mobile_ui/ultils/time_ultil.dart';

class SeenInfo extends StatelessWidget {
  final bool isSender;
  final MessageInteraction? interaction;

  SeenInfo({required this.isSender, this.interaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          interaction != null
              ? Text('Seen at ${formatDate(time: interaction!.createdDate)}')
              : Text('Sent'),
        ],
      ),
    );
  }
}
