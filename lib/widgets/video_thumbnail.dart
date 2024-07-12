import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoThumbnail extends StatelessWidget {
  final String url;

  VideoThumbnail({required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}