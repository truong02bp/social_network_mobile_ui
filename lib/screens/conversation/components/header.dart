import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/screens/conversation/bloc/conversation_bloc.dart';
import 'package:social_network_mobile_ui/screens/conversation/components/conversation_avatar.dart';

class Header extends StatelessWidget {
  final Conversation conversation;

  Header({required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 30,
            width: 30,
            child: Icon(Icons.arrow_back),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        ConversationAvatar(
          conversation: conversation,
        ),
        const SizedBox(
          width: 20,
        ),
        BlocBuilder<ConversationBloc, ConversationState>(
          builder: (context, state) {
            final name = state.name;
            final isActive = state.isActive;
            final leave = state.leave;
            String text = conversation.guests.first.user.username;
            if (isActive) {
              text = 'Active';
            } else {
              if (leave.isNotEmpty) {
                text = '$leave';
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$name',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: 5,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ],
            );
          },
        ),
        Spacer(),
        PopupMenuButton(
          color: AppColor.black2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          itemBuilder: (context) {
            return [
              buildItem(
                  text: 'Call',
                  value: 'call',
                  icon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  )),
              buildItem(
                  text: 'Video call',
                  value: 'video_call',
                  icon: Icon(
                    Icons.videocam_rounded,
                    color: Colors.white,
                  )),
              buildItem(
                  text: 'Search',
                  value: 'search',
                  icon: Icon(Icons.search, color: Colors.white)),
              buildItem(
                  text: 'Nick name',
                  value: 'nick_name',
                  icon: Icon(Icons.drive_file_rename_outline_rounded,
                      color: Colors.white)),
              buildItem(
                  text: 'Media share',
                  value: 'media share',
                  icon: Icon(Icons.perm_media, color: Colors.white)),
              buildItem(
                  text: 'Mute notifications',
                  value: 'mute_notification',
                  icon: Icon(Icons.volume_mute, color: Colors.white)),
            ];
          },
          onSelected: (value) {
            if (value == "video_call") {}
          },
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  PopupMenuItem buildItem(
      {required String text, required String value, required Icon icon}) {
    return PopupMenuItem(
        value: value,
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
