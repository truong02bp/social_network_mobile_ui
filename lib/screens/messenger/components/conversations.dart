import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/messenger/bloc/messenger_bloc.dart';
import 'package:social_network_mobile_ui/screens/messenger/components/conversation_card.dart';

class Conversations extends StatelessWidget {
  ScrollController _scrollController = ScrollController();
  final User user;

  Conversations({required this.user});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MessengerBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.add(GetConversationEvent());
      }
    });
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<MessengerBloc, MessengerState>(
            bloc: bloc,
            buildWhen: (previous, current) =>
                current.status == MessengerStatus.getConversationSuccess ||
                current.status == MessengerStatus.receiveMessage,
            builder: (context, state) {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.conversations.length,
                  addAutomaticKeepAlives: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final conversation = state.conversations[index];
                    if (state.conversationUpdated != null &&
                        state.status == MessengerStatus.receiveMessage) {
                      if (conversation.id == state.conversationUpdated!.id) {
                        return Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ConversationCard(conversation: conversation),
                        );
                      }
                    }
                    return Padding(
                      key: ValueKey(conversation.id),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ConversationCard(conversation: conversation),
                    );
                  });
            },
          ),
        )
      ],
    );
  }
}
