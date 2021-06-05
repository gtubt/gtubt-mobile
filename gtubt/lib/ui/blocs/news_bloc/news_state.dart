import 'package:GTUBT/models/news.dart';

class NewsState {
  bool isLoading;
  bool isLoaded;
  bool isInitial;
  bool isFailed;
  String? errorMessage;
  List<News?>? newsList;

  NewsState({
    required this.isLoading,
    required this.isLoaded,
    required this.isInitial,
    required this.isFailed,
    required this.newsList,
    this.errorMessage,
  });

  factory NewsState.initial() {
    return NewsState(
      isLoading: false,
      isLoaded: true,
      isInitial: true,
      isFailed: false,
      newsList: [],
    );
  }

  factory NewsState.empty() {
    return NewsState(
      isLoading: false,
      isLoaded: true,
      isInitial: false,
      isFailed: false,
      newsList: [],
    );
  }

  factory NewsState.failure(errorMessage) {
    return NewsState(
      isLoading: false,
      isLoaded: false,
      isInitial: false,
      isFailed: true,
      newsList: null,
      errorMessage: errorMessage,
    );
  }

  factory NewsState.loaded(List<News?>? newsList) {
    return NewsState(
      isLoading: false,
      isLoaded: true,
      isInitial: false,
      isFailed: false,
      newsList: newsList,
    );
  }

  factory NewsState.loading() {
    return NewsState(
      isLoading: true,
      isLoaded: false,
      isInitial: false,
      isFailed: false,
      newsList: null,
    );
  }

  @override
  String toString() {
    return '''NewsState {
      isLoading: $isLoading,
      isLoaded: $isLoaded,
      isInitial: $isInitial,
      isFailed: $isFailed,
    }''';
  }
}
