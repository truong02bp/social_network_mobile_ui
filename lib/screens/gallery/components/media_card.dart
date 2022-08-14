import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/constants/content_type.dart';
import 'package:video_player/video_player.dart';

class MediaCard extends StatefulWidget {
  final File media;

  MediaCard({required this.media});

  @override
  State<MediaCard> createState() => _MediaCardState();
}

class _MediaCardState extends State<MediaCard> {
  bool isVideo = false;
  VideoPlayerController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    final contentType =
        widget.media.path.substring(widget.media.path.lastIndexOf(".") + 1);
    isVideo = videoContentType.contains(contentType);
    if (isVideo) {
      _controller = VideoPlayerController.file(widget.media)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      margin: EdgeInsets.only(left: 3, bottom: 3),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: FileImage(widget.media), fit: BoxFit.cover)),
    );
    if (isVideo) {
      final seconds = _controller!.value.duration.inSeconds;
      final minutes = _controller!.value.duration.inMinutes;
      card = Stack(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: VideoPlayer(
              _controller!,
            ),
          ),
          Positioned(bottom: 0, right: 0, child: Text("$minutes:$seconds"))
        ],
      );
    }
    return card;
  }
}
