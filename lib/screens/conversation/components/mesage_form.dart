import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/components/camera_icon.dart';
import 'package:social_network_mobile_ui/components/icon_without_background.dart';
import 'package:social_network_mobile_ui/constants/gallery_constant.dart';
import 'package:social_network_mobile_ui/models/conversation.dart';
import 'package:social_network_mobile_ui/screens/conversation/bloc/conversation_bloc.dart';
import 'package:social_network_mobile_ui/screens/gallery/gallery_screen.dart';

class MessageForm extends StatelessWidget {
  final Conversation conversation;
  TextEditingController textEditingController = TextEditingController();

  MessageForm({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ConversationBloc>(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.withOpacity(0.15),
            ),
            child: TextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.multiline,
              maxLength: null,
              maxLines: null,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  bloc.add(ConversationTypingEvent(isTyping: true));
                } else {
                  bloc.add(ConversationTypingEvent(isTyping: false));
                }
              },
              decoration: InputDecoration(
                hintText: 'Enter message',
                contentPadding: const EdgeInsets.only(left: 20),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
            height: 25,
            width: 25,
            child: Icon(
              Icons.tag_faces,
              color: Color(0xfff78379).withOpacity(0.8),
            )),
        SizedBox(
          width: 10,
        ),
        CameraIcon(solvePicked: (file, type) {
          File media = File(file.path);
          bloc.add(SendMediaMessageEvent(medias: {media}));
        }),
        SizedBox(
          width: 2,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GalleryScreen(
                          type: GalleryConstants.all,
                          option: GalleryConstants.multi,
                          callBackMulti: (selectedFiles) {
                            bloc.add(
                                SendMediaMessageEvent(medias: selectedFiles));
                          },
                        )));
          },
          child: IconWithoutBackground(
            image: "assets/images/gallery.png",
            width: 40,
            height: 40,
            color: Color(0xfff78379).withOpacity(0.8),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        BlocBuilder<ConversationBloc, ConversationState>(
          bloc: bloc,
          buildWhen: (previous, current) =>
              current.status == ConversationStatus.typing,
          builder: (context, state) {
            final isTyping = state.isTyping;
            if (isTyping) {
              return Row(
                children: [
                  IconWithoutBackground(
                    image: "assets/images/send.png",
                    color: Color(0xfff78379).withOpacity(0.8),
                    width: 25,
                    height: 25,
                    onTap: () {
                      bloc.add(SendTextMessageEvent(
                          content: textEditingController.value.text));
                      textEditingController.clear();
                    },
                  ),
                ],
              );
            }
            return IconWithoutBackground(
              image: "assets/images/mic.png",
              color: Color(0xfff78379).withOpacity(0.8),
              width: 25,
              height: 25,
              onTap: () {},
            );
          },
        )
      ],
    );
  }
}
