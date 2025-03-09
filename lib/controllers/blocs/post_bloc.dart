import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post_model.dart';
import '../services/post_service.dart';

abstract class PostEvent {}

class LoadPosts extends PostEvent {}

class PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService postService;

  PostBloc(this.postService) : super(PostLoading()) {
    on<LoadPosts>(_onLoadPosts);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      // Load posts from SharedPreferences first
      List<PostModel> posts = await postService.loadPostsFromStorage();

      // If no cached posts, fetch from API
      if (posts.isEmpty) {
        posts = await postService.fetchPosts();
      }

      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError("Failed to load posts"));
    }
  }
}
