import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/constants/content_type.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/conversation/conversation_screen.dart';

import '../../../constants/host_api.dart';

class ConversationCard extends StatelessWidget {
  final Conversation conversation;

  ConversationCard({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final User user = conversation.guests[0].user;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: CachedNetworkImage(
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Image.asset('assets/images/loading.gif');
          },
          imageUrl: minioHost + user.avatar.url,
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConversationScreen(conversation: conversation)));
      },
      title: Text(
        '${user.name}',
        style: TextStyle(fontSize: 17),
      ),
      subtitle: Text(
        solveLastMessage(message: conversation.lastMessage),
        style: TextStyle(fontSize: 15.5),
      ),
    );
  }

  String solveLastMessage({required Message? message}) {
    if (message == null) {
      return '';
    }
    StringBuffer content = new StringBuffer();
    if (message.sender.id != conversation.user.id) {
      String name = message.sender.user.name;
      if (name.indexOf(" ") != -1) name = name.substring(0, name.indexOf(" "));
      content.write("$name: ");
    } else {
      content.write("you: ");
    }
    if (message.media != null) {
      if (message.media!.contentType == "sticker") {
        content.write("send a sticker");
      } else if (fileContentType.contains(message.media!.contentType)) {
        content.write("send a file");
      } else if (imageContentType.contains(message.media!.contentType)) {
        content.write("send a photo");
      } else {
        content.write("send a video");
      }
    } else {
      if (message.content!.length < 35)
        content.write("${message.content}");
      else
        content.write("${message.content!.substring(0, 35)}...");
    }
    return content.toString();
  }
}
