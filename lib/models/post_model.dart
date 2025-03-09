import 'dart:convert';

class PostModel {
  final int? id;
  final String title;
  final String body;
  final int userId;

  PostModel({
    this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  /// Convert JSON to PostModel
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
    );
  }

  /// Convert PostModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "userId": userId,
    };
  }

  /// Convert JSON String to PostModel
  static PostModel fromJsonString(String jsonString) {
    return PostModel.fromJson(jsonDecode(jsonString));
  }

  /// Convert PostModel to JSON String
  String toJsonString() {
    return jsonEncode(toJson());
  }

  static List<PostModel> fromJsonList(String jsonString) {
    List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((json) => PostModel.fromJson(json)).toList();
  }
}
