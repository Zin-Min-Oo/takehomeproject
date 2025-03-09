import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post_model.dart';
import '../../controllers/services/post_service.dart';
import '../../controllers/blocs/post_bloc.dart';
import '../pages/post_details_page.dart';

class PostListWidget extends StatefulWidget {
  const PostListWidget({super.key});

  @override
  _PostListWidgetState createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<PostModel> _filteredPosts = [];
  List<PostModel> _allPosts = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(PostService())..add(LoadPosts()),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            );
          } else if (state is PostLoaded) {
            _allPosts = state.posts;
            _filteredPosts =
                _searchController.text.isEmpty ? _allPosts : _filteredPosts;

            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search by Title or Body",
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.blueAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _filterPosts,
                  ),
                ),

                // Post List
                Expanded(
                  child: _filteredPosts.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: _filteredPosts.length,
                          itemBuilder: (context, index) {
                            PostModel post = _filteredPosts[index];

                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                title: Text(
                                  post.title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(post.body),
                                trailing: const Icon(Icons.chevron_right,
                                    color: Colors.blueAccent),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          PostDetailsPage(post: post),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : _buildFetchPostsButton(context),
                ),
              ],
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          } else {
            return _buildFetchPostsButton(context);
          }
        },
      ),
    );
  }

  /// Search Functionality
  void _filterPosts(String query) {
    setState(() {
      _filteredPosts = _allPosts.where((post) {
        return post.title.toLowerCase().contains(query.toLowerCase()) ||
            post.body.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  /// Fetch Posts Button UI
  Widget _buildFetchPostsButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              context.read<PostBloc>().add(LoadPosts());
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text(
              "Fetch Posts",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
