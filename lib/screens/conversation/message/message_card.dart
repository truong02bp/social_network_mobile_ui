import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/components/avatar.dart';
import 'package:social_network_mobile_ui/components/time_bar.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/bloc/message_bloc.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/text_card.dart';

class MessageCard extends StatelessWidget {
  Message message;
  Conversation conversation;

  MessageCard({required this.message, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MessageBloc()
          ..add(MessageInitialEvent(
              conversation: conversation, message: message)),
        child: Builder(builder: (context) => _buildView(context)));
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<MessageBloc>(context);
    return BlocBuilder<MessageBloc, MessageState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.message == null) return CircularProgressIndicator();
        bool isSender = state.isSender;
        final messenger = message.sender;
        return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TimeBar(time: message.createdDate),
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              !isSender
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
              Stack(children: [
                TextCard(
                  text: message.content,
                  color: state.color,
                ),
              ]),
            ],
          ),
        ]);
      },
    );
  }
}
