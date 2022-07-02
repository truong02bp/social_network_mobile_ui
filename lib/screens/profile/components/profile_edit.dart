import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';
import 'package:social_network_mobile_ui/screens/profile/edit_profile.dart';

class ProfileEdit extends StatelessWidget {
  final User user;

  ProfileEdit(this.user);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfile(user: user)))
            .then((value) => bloc.add(ProfileInitialEvent()));
      },
      borderRadius: BorderRadius.circular(7),
      child: Container(
        height: 30,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.white.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(7)),
        child: Center(
          child: Text(
            'Edit profile',
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
