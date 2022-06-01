import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_network_mobile_ui/components/back_icon.dart';

import '../../../models/user.dart';

class Header extends StatelessWidget {

  final User user;

  Header({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackIcon(),
        const SizedBox(width: 25,),
        Text('${user.name}', style: TextStyle(fontSize: 18),),
        Spacer(),
        Container(
            height: 20,
            width: 20,
            child: SvgPicture.asset(
              "assets/svgs/add.svg",
              semanticsLabel: 'Acme Logo',
              color: Colors.white,
            )),
      ],
    );
  }
}
