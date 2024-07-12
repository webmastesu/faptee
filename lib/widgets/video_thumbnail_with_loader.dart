import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoThumbnailWithLoader extends StatelessWidget {
  final String thumbnailUrl;
  final bool isLoading;

  VideoThumbnailWithLoader({required this.thumbnailUrl, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16, // Adjust ratio as per your video's aspect ratio (width / height)
      child: Stack(
        fit: StackFit.expand,
        children: [
          // CachedNetworkImage for displaying video thumbnail
          CachedNetworkImage(
            imageUrl: thumbnailUrl,
            placeholder: (context, url) => Container(
              color: Colors.black12, // Placeholder color while loading
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          // Loading indicator if isLoading is true
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
