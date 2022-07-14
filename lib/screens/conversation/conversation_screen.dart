import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/screens/conversation/bloc/conversation_bloc.dart';
import 'package:social_network_mobile_ui/screens/conversation/components/header.dart';
import 'package:social_network_mobile_ui/screens/conversation/components/mesage_form.dart';
import 'package:social_network_mobile_ui/screens/conversation/components/message_list.dart';

class ConversationScreen extends StatelessWidget {
  final Conversation conversation;

  ConversationScreen({required this.conversation});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ConversationBloc()
          ..add(ConversationInitialEvent(conversation: conversation)),
        child: Builder(builder: (context) => _buildView(context)));
  }

  Widget _buildView(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Header(conversation: conversation),
              Expanded(child: MessageList()),
              MessageForm(conversation: conversation)
            ],
          ),
        ),
      ),
    );
  }
}
