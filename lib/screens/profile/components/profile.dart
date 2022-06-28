import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/dto/profile_dto.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';

class Profile extends StatelessWidget {

  final User? user;
  Profile({required this.user});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: CachedNetworkImage(
                height: 70,
                width: 70,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Image.asset('assets/images/loading.gif');
                },
                imageUrl: minioHost + "${user?.avatar.url}",
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: BlocBuilder(
                bloc: bloc,
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
                          const SizedBox(height: 5,),
                          Text('Posts', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                      Column(
                        children: [
                          Text('$followers'),
                          const SizedBox(height: 5,),
                          Text('Followers', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                      Column(
                        children: [
                          Text('$following'),
                          const SizedBox(height: 5,),
                          Text('Following', style: TextStyle(fontSize: 16),),
                        ],
                      )
                    ],
                  );
                }
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text('${user?.name}', style: TextStyle(fontSize: 17),)
      ],
    );
  }
}
