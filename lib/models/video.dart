class Video {
  final String id;
  final String title;
  final String description;
  final String videoPath;
  final String thumbnailPath;
  final String createdAt;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoPath,
    required this.thumbnailPath,
    required this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      videoPath: json['video_path'],
      thumbnailPath: json['thumbnail_path'],
      createdAt: json['created_at'],
    );
  }
}
