import 'package:GTUBT/service/post.dart';
import 'package:GTUBT/ui/blocs/post_bloc/bloc.dart';
import 'package:bloc/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService _postService = PostService();

  PostBloc() : super(PostState.initial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is LoadAllPosts) {
      var result = await _postService.getAll();
      var postState = result.fold((postList) => PostState.success(postList),
          (postFailure) => PostState.failure());
      yield postState;
    } else {
      yield PostState.initial();
    }
  }
}
