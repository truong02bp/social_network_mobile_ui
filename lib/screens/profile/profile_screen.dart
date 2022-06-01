import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';
import 'package:social_network_mobile_ui/screens/profile/components/gallery.dart';
import 'package:social_network_mobile_ui/screens/profile/components/header.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile_drawer.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile_edit.dart';
import 'package:social_network_mobile_ui/screens/profile/components/story_highlights.dart';

import '../../constants/host_api.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    print('rebuild');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        title: Header(),
      ),
      endDrawer: Drawer(
        backgroundColor: AppColor.black,
        child: ProfileDrawer(),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Profile(),
                const SizedBox(
                  height: 25,
                ),
                ProfileEdit(),
                const SizedBox(height: 15,),
                StoryHighlights(),
                const SizedBox(height: 15,),
                Expanded(child: Gallery())
              ],
            )),
      ),
    );
  }
}
