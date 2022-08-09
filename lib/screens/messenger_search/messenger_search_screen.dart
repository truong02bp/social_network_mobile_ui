import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/components/back_icon.dart';

import 'bloc/messenger_search_bloc.dart';
import 'bloc/messenger_search_event.dart';

class MessengerSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MessengerSearchBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<MessengerSearchBloc>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: Column(
            children: [
              BackIcon()
            ],
          ),
        ),
      ),
    );
  }
}

