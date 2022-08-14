import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/constants/gallery_constant.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/gallery/gallery_screen.dart';
import 'package:social_network_mobile_ui/screens/messenger/messenger_screen.dart';

class Header extends StatelessWidget {
  final User user;

  Header({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            child: PopupMenuButton(
              child: SvgPicture.asset(
                "assets/svgs/add.svg",
                semanticsLabel: 'Acme Logo',
                color: Colors.white,
              ),
              color: AppColor.black2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              itemBuilder: (context) {
                return [
                  buildItem(
                      text: 'Create post',
                      value: 'post',
                      icon: Icon(Icons.post_add),
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GalleryScreen(
                                        previewMedia: true,
                                        option: GalleryConstants.multi,
                                        callBackMulti: (files) {
                                          print('callback');
                                        },
                                      )));
                        });
                      }),
                  buildItem(
                      text: 'Create story',
                      value: 'story',
                      icon: Icon(Icons.access_time),
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GalleryScreen(
                                        option: GalleryConstants.single,
                                        callBackSingle: (file) {
                                          print('aa');
                                        },
                                      )));
                        });
                      }),
                  buildItem(
                      text: 'Create video',
                      value: 'video',
                      icon: Icon(Icons.video_call),
                      onTap: () {}),
                ];
              },
            )),
        const SizedBox(
          width: 25,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MessengerScreen(user);
            }));
          },
          child: Container(
              height: 25,
              width: 25,
              child: SvgPicture.asset(
                "assets/svgs/message.svg",
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  PopupMenuItem buildItem(
      {required String text,
      required String value,
      required Icon icon,
      required Function onTap}) {
    return PopupMenuItem(
        value: value,
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text('$text'),
          ],
        ));
  }
}
