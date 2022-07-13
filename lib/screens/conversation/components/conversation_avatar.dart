import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';

class ConversationAvatar extends StatelessWidget {
  final Conversation conversation;

  ConversationAvatar({required this.conversation});

  @override
  Widget build(BuildContext context) {
    String url;
    bool isActive =
        conversation.isGroup ? true : conversation.guests.first.user.isOnline;
    if (conversation.isGroup) {
      if (conversation.media != null)
        url = conversation.media!.url;
      else
        url = "assets/images/group.jpg";
    } else
      url = conversation.guests.first.user.avatar.url;
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: url.contains("assets")
            ? Container(height: 60, width: 60, child: Image.asset(url))
            : CachedNetworkImage(
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Image.asset('assets/images/loading.gif');
                },
                imageUrl: minioHost + url,
              ),
      ),
      Positioned(
        right: 3,
        bottom: 0,
        child: isActive
            ? Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(7)),
              )
            : Container(),
      )
    ]);
  }
}
