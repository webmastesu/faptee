import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fapapp/widgets/video_thumbnail_with_loader.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;

  VideoPlayerScreen({required this.videoUrl, required this.thumbnailUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;
        });
        _controller.play();  // Start playing the video automatically
        _controller.setLooping(true);  // Optional: loop the video
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        // Handle error
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_isLoading)
            VideoThumbnailWithLoader(
              thumbnailUrl: widget.thumbnailUrl,
              isLoading: _isLoading,
            ),
          if (!_isLoading && _controller.value.isInitialized)
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
        ],
      ),
    );
  }
}
