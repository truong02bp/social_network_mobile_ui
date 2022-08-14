import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/components/avatar.dart';
import 'package:social_network_mobile_ui/components/time_bar.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/models/dto/message_dto.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/models/message_interaction.dart';
import 'package:social_network_mobile_ui/screens/conversation/bloc/conversation_bloc.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/chat_bubble_triangle.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/media_message_card.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/message_status.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/reaction_bar.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/reaction_status.dart';
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
  late ConversationBloc bloc;
  Map<String, List<String>> reactionDetails = Map();
  MessageInteraction? guestInteraction;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<ConversationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => _buildView(context));
  }

  @override
  void dispose() {
    super.dispose();
    reactionDetails.clear();
  }

  Widget _buildView(BuildContext context) {
    bool isSender = widget.message.sender.id == widget.conversation.user.id;
    final messenger = widget.message.sender;
    Map<String, List<String>> reactionDetails = Map();
    MessageInteraction? guestInteraction;
    if (widget.message.interactions != null) {
      for (MessageInteraction interaction in widget.message.interactions!) {
        if (interaction.seenBy.id != widget.conversation.user.id) {
          guestInteraction = interaction;
        }
        if (interaction.reaction != null) {
          String? name = interaction.seenBy.nickName;
          if (name == null) name = interaction.seenBy.user.name;
          if (reactionDetails[interaction.reaction!.code] == null) {
            reactionDetails[interaction.reaction!.code] = [];
          }
          reactionDetails[interaction.reaction!.code]!.add(name);
        }
      }
    }
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                onTap: () {
                  setState(() {
                    showDetail = !showDetail;
                  });
                },
                onLongPress: () {
                  showReactionBar();
                },
                child: Stack(children: [
                  Padding(
                    padding: reactionDetails.isNotEmpty
                        ? EdgeInsets.only(left: 8, right: 5, bottom: 7)
                        : EdgeInsets.only(left: 8, right: 5),
                    child: _buildMessageCard(context),
                  ),
                  isSender
                      ? Positioned(
                          bottom: reactionDetails.isNotEmpty ? 4 : -3,
                          right: 8,
                          child: CustomPaint(
                            painter: ChatBubbleTriangle(
                                isSender: isSender,
                                color: getColor(widget.conversation.color)),
                          ))
                      : Container(),
                  reactionDetails.isNotEmpty
                      ? Positioned(
                          key: UniqueKey(),
                          bottom: 0,
                          right: 12,
                          child: ReactionStatus(reactionDetails))
                      : Container(
                          key: UniqueKey(),
                        ),
                ]),
              ),
              widget.needMessageStatus
                  ? MessageStatus(
                      currentUser: widget.conversation.user,
                      message: widget.message,
                      color: widget.conversation.color,
                    )
                  : Container(
                      height: 14,
                      width: 14,
                    ),
            ],
          ),
          showDetail
              ? SeenInfo(
                  isSender: isSender,
                  interaction: guestInteraction,
                )
              : Container()
        ]);
  }

  Widget _buildMessageCard(BuildContext context) {
    switch (widget.message.type) {
      case MessageType.MEDIA:
        return MediaMessageCard(message: widget.message);
      case MessageType.TEXT:
        return TextCard(
          text: widget.message.content,
          color: getColor(widget.conversation.color),
        );
    }
  }

  void showReactionBar() {
    showDialog(
        builder: (context) => Hero(
              tag: 'dash',
              child: ReactionBar(
                callBack: (value) {
                  bloc.add(UpdateMessageEvent(
                      type: "reaction",
                      value: value,
                      messageId: widget.message.id));
                },
              ),
            ),
        context: context);
  }
}
