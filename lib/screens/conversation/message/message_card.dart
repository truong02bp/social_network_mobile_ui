import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/components/avatar.dart';
import 'package:social_network_mobile_ui/components/time_bar.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/message_status.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/reaction_bar.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/seen_info.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/text_card.dart';

class MessageCard extends StatefulWidget {
  Message message;
  Conversation conversation;
  bool showDate;
  bool showAvatar;
  bool needMessageStatus = false;

  MessageCard(
      {required this.message,
      required this.conversation,
      required this.showDate,
      required this.showAvatar,
      required this.needMessageStatus});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  bool showDetail = false;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => _buildView(context));
  }

  Widget _buildView(BuildContext context) {
    bool isSender = widget.message.sender.id == widget.conversation.user.id;
    final messenger = widget.message.sender;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.showDate || showDetail
              ? TimeBar(time: widget.message.createdDate)
              : Container(),
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              !isSender && widget.showAvatar
                  ? Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Avatar(
                        url: messenger.user.avatar.url,
                        size: 35,
                      ))
                  : Container(
                      height: 35,
                      width: 40,
                    ),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  setState(() {
                    showDetail = !showDetail;
                  });
                },
                onLongPress: () {
                  showReactionBar();
                },
                child: Stack(children: [
                  TextCard(
                    text: widget.message.content,
                    color: getColor(widget.conversation.color),
                  ),
                ]),
              ),
              const SizedBox(
                width: 2,
              ),
              widget.needMessageStatus
                  ? MessageStatus(
                      currentUser: widget.conversation.user,
                      message: widget.message,
                      color: widget.conversation.color,
                    )
                  : Container(),
            ],
          ),
          showDetail
              ? SeenInfo(
                  isSender: isSender,
                  interactions: widget.message.interactions,
                )
              : Container(),
        ]);
  }

  void showReactionBar() {
    showDialog(
        builder: (context) => Hero(
              tag: 'dash',
              child: ReactionBar(
                callBack: (value) {
                  print(value);
                },
              ),
            ),
        context: context);
  }
}
