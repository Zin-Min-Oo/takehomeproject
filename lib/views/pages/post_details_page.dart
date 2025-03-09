import 'package:flutter/material.dart';
import '../../models/post_model.dart';

class PostDetailsPage extends StatelessWidget {
  final PostModel post;

  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Post Title
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 10),

                // Post ID
                Row(
                  children: [
                    const Icon(Icons.numbers, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Text("Post ID: ${post.id}",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),

                // User ID
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Text("User ID: ${post.userId}",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),

                // Post Body
                const Text(
                  "Post Content",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  post.body,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
