import 'package:GTUBT/service/post.dart';
import 'package:GTUBT/ui/blocs/post_bloc/post_event.dart';
import 'package:GTUBT/ui/blocs/post_bloc/post_state.dart';
import 'package:bloc/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService _postService = PostService();

  @override
  PostState get initialState => PostState.initial();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if(event is LoadAllPosts){
      var result = await _postService.getAll();
      var postState = result.fold(
        (postList) => PostState.success(postList),
        (postFailure) => PostState.failure()
      );
      yield postState;
    }
    else{
      yield this.initialState;
    }
  }
}