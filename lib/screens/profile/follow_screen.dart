import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile_drawer.dart';

class FollowScreen extends StatelessWidget {
  final User user;
  int initialIndex;
  late ProfileBloc bloc;

  FollowScreen({required this.user, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileInitialEvent()),
      child: Builder(builder: (context) => _buildView(context)),
    );
  }

  Widget _buildView(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              '${user.username}',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
          ],
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: AppColor.black,
        child: ProfileDrawer(),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: initialIndex,
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              _buildTabFollowers(),
              _buildTabFollowing(),
            ],
          ),
          body: TabBarView(
            children: [
              _buildViewFollowers(context),
              _buildViewFollowing(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewFollowers(BuildContext context) {
    return Text('AAA');
  }

  Widget _buildViewFollowing(BuildContext context) {
    return Text('BBB');
  }

  Widget _buildTabFollowers() {
    return Tab(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: bloc,
        buildWhen: (previous, current) => current is GetProfileSuccess,
        builder: (context, state) {
          int followers = 0;
          if (state is GetProfileSuccess) {
            followers = state.profileDto.followers;
          }
          return Text(
            '$followers followers',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.5,
                fontWeight: FontWeight.w800),
          );
        },
      ),
    );
  }

  Widget _buildTabFollowing() {
    return Tab(
        child: BlocBuilder<ProfileBloc, ProfileState>(
      bloc: bloc,
      buildWhen: (previous, current) => current is GetProfileSuccess,
      builder: (context, state) {
        int following = 0;
        if (state is GetProfileSuccess) {
          following = state.profileDto.following;
        }
        return Text(
          '$following following',
          style: TextStyle(
              color: Colors.white, fontSize: 15.5, fontWeight: FontWeight.w800),
        );
      },
    ));
  }
}
