import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/media.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final Media video;

  VideoCard({required this.video});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  ChewieController? chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVideo();
  }

  Future<void> initVideo() async {
    _controller = VideoPlayerController.network(minioHost + widget.video.url);
    await _controller.initialize();
    chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: _controller.value.aspectRatio,
      placeholder: Center(
          child: Image.asset(
        "assets/images/loading.gif",
        height: 100,
        width: 100,
      )),
      showControls: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: false,
      looping: true,
      autoPlay: false,
      startAt: Duration(milliseconds: 0),
    );
    chewieController!.setVolume(5.0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initVideo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
              child: Image.asset(
            "assets/images/loading.gif",
            height: 100,
            width: 100,
          ));
        }
        return AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Chewie(
              controller: chewieController!,
            ),
          ),
        );
      },
    );
  }
}
