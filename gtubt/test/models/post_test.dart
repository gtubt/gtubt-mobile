import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/news.dart';

void main() {
  test('Serialize News', () {
    DateTime now = DateTime.now();
    News announcement = News(
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      title: "News Title",
      summary: "Summary of the announcement to display in summary card.",
      coverImageUrl: "http://someurl.com/somepath",
      type: NewsType.announcement,
      startDate: now,
      endDate: now,
    );

    expect(json.encode(announcement.toJson()),
        '{"title":"News Title","body":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","coverImageUrl":"http://someurl.com/somepath","summary":"Summary of the announcement to display in summary card.","type":"announcement","startDate":"$now","endDate":"$now"}');
  });

  test('Deserialize News', () {
    DateTime now = DateTime.now();
    News announcement = News(
        body: 'Lorem ipsum dolor sit amet,',
        title: "News Title",
        summary: "Summary of the announcement to display in summary card.",
        coverImageUrl: "http://someurl.com/somepath",
        type: NewsType.news,
        startDate: now,
        endDate: now);

    Map<String, dynamic> data = json.decode(
        '{"title":"News Title","body":"Lorem ipsum dolor sit amet,","coverImageUrl":"http://someurl.com/somepath","summary":"Summary of the announcement to display in summary card.","type":"news","startDate":"$now","endDate":"$now"}');

    expect(announcement.body, News.fromJson(data).body);
    expect(announcement.title, News.fromJson(data).title);
    expect(announcement.summary, News.fromJson(data).summary);
    expect(announcement.coverImageUrl, News.fromJson(data).coverImageUrl);
    expect(announcement.type, News.fromJson(data).type);
    expect(announcement.startDate, News.fromJson(data).startDate);
    expect(announcement.endDate, News.fromJson(data).endDate);
  });

  test('Update News', () {
    DateTime now = DateTime.now();
    News announcement = News(
        body: 'Lorem ipsum dolor sit amet,',
        title: "News Title",
        summary: "Summary of the announcement to display in summary card.",
        coverImageUrl: "http://someurl.com/somepath",
        type: NewsType.news,
        startDate: now,
        endDate: now);

    announcement.title = announcement.title + " New";

    expect(announcement.title, "News Title New");
    expect(announcement.coverImageUrl, "http://someurl.com/somepath");
  });
}
