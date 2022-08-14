import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/post_creation/bloc/post_creation_bloc.dart';

class PostCreationScreen extends StatelessWidget {
  final List<File> files;

  PostCreationScreen({required this.files});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCreationBloc(),
      child: Builder(builder: (context) => _buildView()),
    );
  }

  Widget _buildView() {
    return Container();
  }
}
