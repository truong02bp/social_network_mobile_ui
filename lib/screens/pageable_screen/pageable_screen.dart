import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/screens/home/bloc/home_bloc.dart';
import 'package:social_network_mobile_ui/screens/home/home_screen.dart';
import 'package:social_network_mobile_ui/screens/notification/notification_screen.dart';
import 'package:social_network_mobile_ui/screens/personal/personal_screen.dart';
import 'package:social_network_mobile_ui/screens/search/bloc/search_bloc.dart';
import 'package:social_network_mobile_ui/screens/video_network/bloc/video_network_bloc.dart';
import 'package:social_network_mobile_ui/screens/notification/bloc/notification_bloc.dart';
import 'package:social_network_mobile_ui/screens/personal/bloc/personal_bloc.dart';
import 'package:social_network_mobile_ui/screens/search/search_screen.dart';
import 'package:social_network_mobile_ui/screens/video_network/video_network_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageableScreen extends StatefulWidget {
  const PageableScreen({Key? key}) : super(key: key);

  @override
  State<PageableScreen> createState() => _PageableScreenState();
}

class _PageableScreenState extends State<PageableScreen> {
  List screens = [
    BlocProvider(
      create: (context) => HomeBloc()..add(FetchDataHomeEvent()),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => SearchBloc(),
      child: SearchScreen(),
    ),
    BlocProvider(
      create: (context) => VideoNetworkBloc(),
      child: VideoNetworkScreen(),
    ),
    BlocProvider(
      create: (context) => NotificationBloc(),
      child: NotificationScreen(),
    ),
    BlocProvider(
      create: (context) => PersonalBloc(),
      child: PersonalScreen(),
    ),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color color = AppColor.black3;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                "assets/svgs/home.svg",
                width: 25,
                height: 25,
                color: currentIndex == 0 ? Colors.white : Colors.grey,
              ),
            ),
            label: '',
            backgroundColor: color,
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/search.svg",
                width: 25,
                height: 25,
                color: currentIndex == 1 ? Colors.white : Colors.grey,
              ),
              label: '',
              backgroundColor: color),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/video-player.svg",
                width: 25,
                height: 25,
                color: currentIndex == 2 ? Colors.white : Colors.grey,
              ),
              label: '',
              backgroundColor: color),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/heart.svg",
                width: 25,
                height: 25,
                color: currentIndex == 3 ? Colors.white : Colors.grey,
              ),
              label: '',
              backgroundColor: color),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/heart.svg",
                width: 25,
                height: 25,
                color: currentIndex == 4 ? Colors.white : Colors.grey,
                fit: BoxFit.fill,
              ),
              label: '',
              backgroundColor: color),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}