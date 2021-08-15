import 'package:GTUBT/exceptions/news.dart';
import 'package:GTUBT/models/news.dart';
import 'package:GTUBT/models/paginated_response.dart';
import 'package:GTUBT/service/service.dart';
import 'dart:convert';

class NewsService extends BaseService {
  static final NewsService _newsService = NewsService._internal();
  final servicePath = 'news';
  NewsService._internal();

  factory NewsService() {
    return _newsService;
  }

  Future<List<News?>?> getAll() async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/all/';

    final response = await GET('$url');

    if (response.statusCode != 200) {
      throw NewsException();
    }
    try {
      PaginatedResponse paginatedResponse = PaginatedResponse.fromJson(json.decode(response.body));
      List<News> body = paginatedResponse.results!.map((e) => News.fromJson(e)).toList().reversed.toList();

      return body;
    } catch (_) {
      throw NewsException();
    }
  }

  Future<News?> get(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await GET('$url');
    if (response.statusCode != 200) {
      throw NewsException();
    }
    try {
      final apiResponse = News.fromJson(json.decode(response.body));
      return apiResponse;
    } catch (e) {
      throw NewsException();
    }
  }

  Future<News?> news(News news) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath';
    try {
      var newsInJson = news.toJson();
      var bodyData = json.encode(newsInJson);

      final response = await POST('$url',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData);
      if (response.statusCode != 200) {
        throw NewsException();
      }

      final apiResponse = News.fromJson(json.decode(response.body));
      return apiResponse;
    } catch (_) {
      throw NewsException();
    }
  }
}
