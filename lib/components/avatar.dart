import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double size;

  Avatar({required this.url, this.size = 70});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: CachedNetworkImage(
        height: size,
        width: size,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return Image.asset('assets/images/loading.gif');
        },
        imageUrl: minioHost + url,
      ),
    );
  }
}
