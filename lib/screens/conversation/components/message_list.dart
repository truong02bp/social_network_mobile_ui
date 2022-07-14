import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/conversation/bloc/conversation_bloc.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/message_card.dart';

class MessageList extends StatelessWidget {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ConversationBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.add(GetMessageEvent());
      }
    });

    return BlocBuilder<ConversationBloc, ConversationState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          current.status == ConversationStatus.getMessageSuccess,
      builder: (context, state) {
        final conversation = state.conversation;
        return ListView.builder(
            controller: _scrollController,
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: state.messages.length,
            reverse: true,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              // calculate show date
              bool showDate = false;
              if (index == state.messages.length - 1)
                showDate = true;
              else {
                int minute = message.createdDate
                    .difference(state.messages[index + 1].createdDate)
                    .inMinutes;
                if (minute > 5) showDate = true;
              }
              // calculate show avatar
              bool showAvatar = false;
              if (conversation!.user.id != message.sender.id) {
                if (index == 0) {
                  showAvatar = true;
                } else {
                  if (state.messages[index - 1].sender.id ==
                      message.sender.id) {
                    int minute = state.messages[index - 1].createdDate
                        .difference(message.createdDate)
                        .inMinutes;
                    if (minute > 5) {
                      showAvatar = true;
                    }
                  } else {
                    showAvatar = true;
                  }
                }
              }
              return MessageCard(
                message: message,
                conversation: conversation,
                showDate: showDate,
                showAvatar: showAvatar,
              );
            });
      },
    );
  }
}
