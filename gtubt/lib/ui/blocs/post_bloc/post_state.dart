import 'package:GTUBT/models/post.dart';
import 'package:meta/meta.dart';

class PostState {
  bool isLoading;
  bool isSuccess;
  bool isInitial;

  List<Post> postList;

  PostState({
    @required this.isLoading,
    @required this.isSuccess,
    @required this.isInitial,
    @required this.postList,
  });

  factory PostState.initial() {
    return PostState(
      isLoading: false,
      isSuccess: true,
      isInitial: true,
      postList: new List<Post>(),
    );
  }

  factory PostState.empty() {
    return PostState(
      isLoading: false,
      isSuccess: true,
      isInitial: false,
      postList: new List<Post>(),
    );
  }

  factory PostState.failure() {
    return PostState(
      isLoading: false,
      isSuccess: false,
      isInitial: false,
      postList: null,
    );
  }

  factory PostState.success(List<Post> postList) {
    return PostState(
      isLoading: false,
      isSuccess: true,
      isInitial: false,
      postList: postList,
    );
  }

  factory PostState.loading() {
    return PostState(
      isLoading: true,
      isSuccess: false,
      postList: null,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isLoading: $isLoading,
      isSuccess: $isSuccess,
    }''';
  }
}
