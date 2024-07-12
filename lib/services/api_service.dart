import 'dart:convert';
import 'package:http/http.dart' as http;


import '../models/video.dart';

class ApiService {
  static const String apiUrl = "https://nano.109110.xyz/api.php";

  Future<List<Video>> fetchVideos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((video) => Video.fromJson(video)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }

  Future<List<Video>> searchVideos(String query) async {
    final response = await http.get(Uri.parse('$apiUrl?search=$query'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((video) => Video.fromJson(video)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}