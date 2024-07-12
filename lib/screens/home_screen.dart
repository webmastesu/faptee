import 'package:flutter/material.dart';
import 'package:fapapp/models/video.dart';
import 'package:fapapp/services/api_service.dart';
import 'package:fapapp/widgets/video_thumbnail_with_loader.dart';
import 'package:fapapp/screens/video_player_screen.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Video>>? _videosFuture;

  @override
  void initState() {
    super.initState();
    _videosFuture = ApiService().fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Video>>(
        future: _videosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No videos available'));
          } else {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final video = snapshot.data![index];
                return VideoPlayerItem(
                  videoUrl: video.videoPath,
                  thumbnailUrl: video.thumbnailPath,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;

  VideoPlayerItem({required this.videoUrl, required this.thumbnailUrl});

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
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
        _controller.play(); // Auto-play the video
        _controller.setLooping(true); // Loop the video
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
    return Stack(
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
    );
  }
}