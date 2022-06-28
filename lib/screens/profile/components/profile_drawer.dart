import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/routers.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';

class ProfileDrawer extends StatefulWidget {
  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: DrawerHeader(
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              buildItem(
                  icon: Icon(Icons.group,
                      color: Color(0xfff78379).withOpacity(0.8)),
                  title: 'New group',
                  onTap: () {}),
              buildItem(
                  icon: Icon(Icons.location_history_rounded,
                      color: Color(0xfff78379).withOpacity(0.8)),
                  title: 'Contacts',
                  onTap: () {}),
              buildItem(
                  icon: Icon(Icons.save_rounded,
                      color: Color(0xfff78379).withOpacity(0.8)),
                  title: 'Saved Messages',
                  onTap: () {}),
              buildItem(
                  icon: Icon(Icons.settings,
                      color: Color(0xfff78379).withOpacity(0.8)),
                  title: 'Settings',
                  onTap: () {}),
              buildItem(
                  icon: Icon(Icons.share,
                      color: Color(0xfff78379).withOpacity(0.8)),
                  title: 'Invite Friends',
                  onTap: () {}),
              buildItem(
                  icon: Icon(Icons.logout,
                      color: Color(0xfff78379).withOpacity(0.8)),
                  title: 'Log out',
                  onTap: () {
                      bloc.add(ProfileLogout());
                      pushReplacementLoginScreen(context: context);
                  }),
            ])),
      )
    ]);
  }

  Widget buildItem(
      {required Icon icon, required String title, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 20,
            ),
            Text(
              '$title',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
