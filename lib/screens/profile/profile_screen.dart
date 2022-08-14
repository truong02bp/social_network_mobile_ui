import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';
import 'package:social_network_mobile_ui/screens/profile/components/header.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile_drawer.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile_edit.dart';
import 'package:social_network_mobile_ui/screens/profile/components/story_highlights.dart';

class ProfileScreen extends StatelessWidget {
  User? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileInitialEvent()),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder(
        bloc: bloc,
        buildWhen: (previous, current) {
          return current is GetUserSuccess;
        },
        builder: (context, state) {
          if (state is GetUserSuccess) {
            user = state.user;
          }
          if (user != null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColor.black,
                title: Header(
                  user: user,
                ),
              ),
              endDrawer: Drawer(
                backgroundColor: AppColor.black,
                child: ProfileDrawer(),
              ),
              body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Profile(
                            user: user,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ProfileEdit(user!),
                          const SizedBox(
                            height: 15,
                          ),
                          StoryHighlights(),
                          const SizedBox(
                            height: 15,
                          ),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       flex: 1,
                          //       child: Container(
                          //         height: 40,
                          //         padding: EdgeInsets.all(7),
                          //         child: SvgPicture.asset(
                          //           "assets/svgs/grid.svg",
                          //           height: 20,
                          //           width: 20,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       flex: 1,
                          //       child: Container(
                          //         height: 40,
                          //         padding: EdgeInsets.all(7),
                          //         child: SvgPicture.asset(
                          //           "assets/svgs/personal.svg",
                          //           height: 25,
                          //           width: 25,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // Container(
                          //   height: 1000,
                          // )
                        ],
                      ),
                    )),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
