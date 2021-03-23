import 'package:GTUBT/models/post.dart';
import 'package:meta/meta.dart';

class PostState {
  bool isLoading;
  bool isLoaded;
  bool isInitial;
  bool isFailed;
  String errorMessage;
  List<Post> postList;

  PostState({
    @required this.isLoading,
    @required this.isLoaded,
    @required this.isInitial,
    @required this.isFailed,
    @required this.postList,
    this.errorMessage,
  });

  factory PostState.initial() {
    return PostState(
      isLoading: false,
      isLoaded: true,
      isInitial: true,
      isFailed: false,
      postList: List<Post>(),
    );
  }

  factory PostState.empty() {
    return PostState(
      isLoading: false,
      isLoaded: true,
      isInitial: false,
      isFailed: false,
      postList: List<Post>(),
    );
  }

  factory PostState.failure(errorMessage) {
    return PostState(
      isLoading: false,
      isLoaded: false,
      isInitial: false,
      isFailed: true,
      postList: null,
      errorMessage: errorMessage,
    );
  }

  factory PostState.loaded(List<Post> postList) {
    return PostState(
      isLoading: false,
      isLoaded: true,
      isInitial: false,
      isFailed: false,
      postList: postList,
    );
  }

  factory PostState.loading() {
    return PostState(
      isLoading: true,
      isLoaded: false,
      isInitial: false,
      isFailed: false,
      postList: null,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isLoading: $isLoading,
      isLoaded: $isLoaded,
      isInitial: $isInitial,
      isFailed: $isFailed,
    }''';
  }
}
