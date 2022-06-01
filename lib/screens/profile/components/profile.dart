import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';

class Profile extends StatelessWidget {

  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                imageUrl: minioHost + "/anonymous.png",
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('1'),
                      const SizedBox(height: 5,),
                      Text('Posts', style: TextStyle(fontSize: 16),),
                    ],
                  ),
                  Column(
                    children: [
                      Text('78'),
                      const SizedBox(height: 5,),
                      Text('Followers', style: TextStyle(fontSize: 16),),
                    ],
                  ),
                  Column(
                    children: [
                      Text('121'),
                      const SizedBox(height: 5,),
                      Text('Following', style: TextStyle(fontSize: 16),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Huy Trường', style: TextStyle(fontSize: 17),)
      ],
    );
  }
}
