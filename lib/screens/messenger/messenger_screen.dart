import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/messenger/bloc/messenger_bloc.dart';
import 'package:social_network_mobile_ui/screens/messenger/components/conversations.dart';
import 'package:social_network_mobile_ui/screens/messenger/components/header.dart';
import 'package:social_network_mobile_ui/screens/messenger/components/search_bar.dart';

class MessengerScreen extends StatelessWidget {
  final User user;

  MessengerScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          MessengerBloc()..add(MessengerInitialEvent(user: user)),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(user: user),
              const SizedBox(
                height: 20,
              ),
              SearchBar(),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Messages',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(child: Conversations(user: user)),
            ],
          ),
        ),
      ),
    );
  }
}
