import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/messenger/components/header.dart';
import 'package:social_network_mobile_ui/screens/messenger/components/search_bar.dart';

import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';

class MessengerScreen extends StatelessWidget {
  final User user;
  int page = 0;
  int limit = 20;

  MessengerScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MessengerBloc()
        ..add(GetConversationEvent(userId: user.id, page: page, limit: limit)),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<MessengerBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Header(user: user),
              const SizedBox(
                height: 20,
              ),
              SearchBar()
            ],
          ),
        ),
      ),
    );
  }
}
