import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
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
            borderRadius: BorderRadius.circular(7)
        ),
        child: Center(child: Text('Edit profile', style: TextStyle(fontSize: 17),),),
      ),
    );
  }
}
