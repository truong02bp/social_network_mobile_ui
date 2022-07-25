import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/constants/content_type.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/models/message_media.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/image_card.dart';
import 'package:social_network_mobile_ui/screens/conversation/message/components/video_card.dart';

class MediaMessageCard extends StatelessWidget {
  final Message message;

  MediaMessageCard({required this.message});

  @override
  Widget build(BuildContext context) {
    final medias = [];
    if (message.medias != null) {
      medias.addAll(message.medias!);
    }
    return Container(
      constraints: new BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 4 / 7),
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: medias.length == 1 ? 1 : 2),
        shrinkWrap: true,
        itemCount: medias.length,
        itemBuilder: (context, index) {
          final media = medias[index];
          return _buildCard(media: media, context: context);
        },
      ),
    );
  }

  Widget _buildCard(
      {required MessageMedia media, required BuildContext context}) {
    final contentType = media.contentType;
    bool isVideo = videoContentType.contains(contentType);
    if (!isVideo) {
      return ImageCard(media);
    }
    return VideoCard(video: media);
  }
}
