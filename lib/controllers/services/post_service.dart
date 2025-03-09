import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/post_model.dart';
import 'dart:convert';

class PostService {
  final Dio dio = Dio();
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  /// Fetch posts from API and store in SharedPreferences
  Future<List<PostModel>> fetchPosts() async {
    try {
      Response response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<PostModel> posts =
            PostModel.fromJsonList(jsonEncode(response.data));
        await _savePostsToStorage(posts);
        return posts;
      }
      return [];
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }

  /// Save posts to SharedPreferences
  Future<void> _savePostsToStorage(List<PostModel> posts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonPosts = jsonEncode(posts.map((post) => post.toJson()).toList());
    await prefs.setString('posts', jsonPosts);
  }

  /// Load posts from SharedPreferences
  Future<List<PostModel>> loadPostsFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonPosts = prefs.getString('posts');
    if (jsonPosts != null) {
      List<dynamic> jsonData = jsonDecode(jsonPosts);
      return jsonData.map((json) => PostModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<PostModel?> createPost(PostModel post) async {
    try {
      Response response = await dio.post(
        apiUrl,
        data: post.toJson(), // Send PostModel as JSON
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print("Response: ${response.data}");
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 201) {
        return PostModel.fromJson(
          response.data,
        );
      }
    } catch (e) {
      print("Error uploading post: $e");
    }
    return null;
  }
}
