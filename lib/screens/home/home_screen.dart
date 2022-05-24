import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_network_mobile_ui/components/loading_icon.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  HomeBloc? homeBloc;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocListener(
        bloc: homeBloc,
        listener: (context, state) {
          if (state is FetchDataHomeState) {
            setState(() {
              user = state.user;
              isLoading = false;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: isLoading
              ? Center(child: LoadingIcon(height: 100, width: 100))
              : Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Instagram',
                          style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Container(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              "assets/svgs/add.svg",
                              semanticsLabel: 'Acme Logo',
                              color: Colors.white,
                            )),
                        const SizedBox(
                          width: 25,
                        ),
                        Container(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              "assets/svgs/message.svg",
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Text('${user!.name}')
                  ],
                ),
        ),
      )),
    );
  }
}
