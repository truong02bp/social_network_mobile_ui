import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/components/dot_seen.dart';
import 'package:social_network_mobile_ui/components/dot_send.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/models/message_interaction.dart';

import '../../../../models/messenger.dart';

class MessageStatus extends StatelessWidget {
  final Message message;
  final Messenger currentUser;
  final String? color;

  MessageStatus({required this.message, required this.currentUser, this.color});

  @override
  Widget build(BuildContext context) {
    List<MessageInteraction> interactions = [];
    interactions.addAll(message.messageInteractions!);
    interactions.removeWhere((element) => element.seenBy.id == currentUser.id);
    if (message.sender.id == currentUser.id) {
      if (interactions.isNotEmpty)
        return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
                interactions.length,
                (index) => DotSeen(
                    minioHost + interactions[index].seenBy.user.avatar.url)));
      else
        return DotSend(color: getColor(color));
    }
    return Container();
  }
}
