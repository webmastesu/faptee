import 'package:fapapp/screens/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:fapapp/models/video.dart';
import 'package:fapapp/services/api_service.dart';
import 'package:fapapp/widgets/video_thumbnail.dart';

import '../models/video.dart';
import '../services/api_service.dart';
import '../widgets/video_thumbnail.dart';
import '../widgets/video_thumbnail_with_loader.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  Future<List<Video>>? _searchResults;

  void _performSearch(String query) {
    setState(() {
      _searchResults = ApiService().searchVideos(query);
    });
  }

  void _navigateToVideoPlayer(Video video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          videoUrl: video.videoPath,
          thumbnailUrl: video.thumbnailPath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
        ),
      ),
      body: _searchResults == null
          ? Center(child: Text('Search for videos'))
          : FutureBuilder<List<Video>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final video = snapshot.data![index];
                return ListTile(
                  title: Text(video.title),
                  subtitle: Text(video.description),
                  leading: VideoThumbnailWithLoader(
                    thumbnailUrl: video.thumbnailPath,
                  ),
                  onTap: () => _navigateToVideoPlayer(video),
                );
              },
            );
          }
        },
      ),
    );
  }
}