import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Gallery extends StatelessWidget {
  List<Widget> widgets = [
    Container(
      height: 500,
      color: Colors.red,
    ),
    Container(
      height: 500,
      color: Colors.green,
    ),
    Container(
      height: 500,
      color: Colors.red,
    ),
    Container(
      height: 500,
      color: Colors.green,
    ),
    Container(
      height: 500,
      color: Colors.red,
    ),
    Container(
      height: 500,
      color: Colors.green,
    ),
    Container(
      height: 500,
      color: Colors.red,
    ),
    Container(
      height: 500,
      color: Colors.green,
    ),
    Container(
      height: 500,
      color: Colors.red,
    ),
    Container(
      height: 500,
      color: Colors.green,
    ),
    Container(
      height: 500,
      color: Colors.red,
    ),
    Container(
      height: 500,
      color: Colors.green,
    ),
    Container(
      height: 500,
      color: Colors.red,
    ),
    Container(
      height: 500,
      color: Colors.green,
    ),
    Container(
      height: 500,
      color: Colors.red,
    ),
    Container(
      height: 500,
      color: Colors.green,
    ),
    Container(
      height: 500,
      color: Colors.red,
    ),
    Container(
      height: 500,
      color: Colors.green,
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: TabBar(
        tabs: [
          Tab(
            icon: SvgPicture.asset("assets/svgs/grid.svg", height: 25,
              width: 25,
              color: Colors.white,),
          ),
          Tab(
            icon: SvgPicture.asset("assets/svgs/personal.svg", height: 25,
              width: 25,
              color: Colors.white,),
          ),
        ],
      ),
      body: TabBarView(
        children: [
          GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
            children: widgets,),
          GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
            children: widgets,),
        ],
      ),
    ));
  }
}
