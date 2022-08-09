import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/components/loading_icon.dart';
import 'package:social_network_mobile_ui/screens/home/bloc/home_bloc.dart';

import 'components/body.dart';
import 'components/header.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: BlocBuilder<HomeBloc, HomeState>(
              bloc: bloc,
              builder: (context, state) {
                if (state.user == null) {
                  return LoadingIcon(height: 100, width: 100);
                }
                return Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                      child: Header(user: state.user!),
                    ),
                    Expanded(child: Body(state.user!))
                  ],
                );
              }),
        ),
      ),
    );
  }
}
