import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';

class Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    return Row(
      children: [
        Icon(Icons.lock, color: Colors.white,),
        const SizedBox(width: 30,),
        Text('Huy Trường', style: TextStyle(fontSize: 18),),
        Spacer(),
      ],
    );
  }
}
