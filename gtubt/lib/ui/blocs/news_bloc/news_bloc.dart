import 'package:GTUBT/exceptions/news.dart';
import 'package:GTUBT/models/news.dart';
import 'package:GTUBT/service/news.dart';
import 'package:GTUBT/ui/blocs/news_bloc/bloc.dart';
import 'package:bloc/bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService _newsService = NewsService();

  NewsBloc() : super(NewsState.initial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNews) {
      yield NewsState.loading();
      try {
        List<News> news = await _newsService.getAll();
        yield NewsState.loaded(news);
      } on NewsException catch (err) {
        yield NewsState.failure(err.message);
      }
    }
  }
}
