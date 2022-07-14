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
              return MessageCard(message: message, conversation: conversation!);
            });
      },
    );
  }
}
