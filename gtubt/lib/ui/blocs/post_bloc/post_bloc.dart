import 'package:GTUBT/exceptions/post.dart';
import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/service/post.dart';
import 'package:GTUBT/ui/blocs/post_bloc/bloc.dart';
import 'package:bloc/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService _postService = PostService();

  PostBloc() : super(PostState.initial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is FetchPosts) {
      yield PostState.loading();
      try {
        List<Post> posts = await _postService.getAll();
        yield PostState.loaded(posts);
      } on PostException catch (err) {
        yield PostState.failure(err.message);
      }
    }
  }
}
