import 'package:GTUBT/service/news.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/news.dart';
import 'package:http/http.dart' as http;

void main() {
  test('ENDPOINT=NEWS METHOD=GET URL=/news', () async {
    List<News?>? news = await NewsService().getAll();
    
    expect(news == null, false);
    expect(news!.length > 0, true);
  });

  test('ENDPOINT=NEWS METHOD=GET URL=/news/(id)', () async {
    News? news  = await NewsService().get("TEST_NEWS_DONT_DELETE");
    
    expect(news == null, false);
    expect(news!.type, NewsType.news);
    expect(news.title, "TEST_TITLE");
    expect(news.summary, "TEST_SUMMARY");
    expect(news.body, "TEST_BODY");
  });

  test('ENDPOINT=NEWS METHOD=NEWS URL=/news', () async {
    News news = new News();
    news.title = "TEST_NEW_NEWS_TITLE";
    news.body = "TEST_NEW_NEWS_BODY";
    news.coverImageUrl = "TEST_NEW_NEWS_COVER_IMAGE_URL";
    news.summary = "TEST_NEW_NEWS_SUMMARY";
    news.type = NewsType.news;
    news.startDate = DateTime(2020, 7, 13, 15, 30);
    news.endDate = DateTime(2020, 7, 13, 15, 30);
    http.Response response = (await NewsService().news(news)) as http.Response;
    expect(response.statusCode == 200, true);
  });
}
