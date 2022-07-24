import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/models/message_media.dart';

class ImageCard extends StatelessWidget {
  final Message message;

  ImageCard({required this.message});

  @override
  Widget build(BuildContext context) {
    final images = [];
    if (message.medias != null) {
      images.addAll(message.medias!);
    }
    return Container(
      constraints: new BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 4 / 7),
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: images.length == 1 ? 1 : 2),
        shrinkWrap: true,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return _buildImageCard(image: image, context: context);
        },
      ),
    );
  }

  Widget _buildImageCard(
      {required MessageMedia image, required BuildContext context}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullScreenImage(url: image.url)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Hero(
          tag: 'image-card-${image.url}',
          child: Container(
            margin: EdgeInsets.only(left: 3, bottom: 3),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(minioHost + image.url),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final String url;

  FullScreenImage({required this.url});

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool showRollBack = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  showRollBack = !showRollBack;
                });
              },
              child: Hero(
                tag: 'image',
                child: PhotoView(
                  backgroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  imageProvider: NetworkImage(minioHost + widget.url),
                ),
              ),
            ),
            showRollBack
                ? Positioned(
                    top: 15,
                    left: 30,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 25,
                          height: 25,
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(Icons.arrow_back_ios))),
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
