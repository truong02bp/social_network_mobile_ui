import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/follower/follower_screen.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';
import 'package:social_network_mobile_ui/screens/profile/components/avatar.dart';

class Profile extends StatelessWidget {
  User? user;
  late ProfileBloc bloc;

  Profile({required this.user});

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Avatar(
              user: user,
              size: 90,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: BlocBuilder(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      current is GetProfileSuccess,
                  builder: (context, state) {
                    int posts = 0;
                    int followers = 0;
                    int following = 0;
                    if (state is GetProfileSuccess) {
                      posts = state.profileDto.posts;
                      followers = state.profileDto.followers;
                      following = state.profileDto.following;
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text('$posts'),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Posts',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FollowerScreen(user: user!)));
                          },
                          child: Column(
                            children: [
                              Text('$followers'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Followers',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => FollowerScreen(
                            //               user: user!,
                            //             )));
                          },
                          child: Column(
                            children: [
                              Text('$following'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Following',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '${user?.name}',
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }
}
