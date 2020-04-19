import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/post.dart';

void main() {
  test('Serialize Post', () {
    DateTime now = DateTime.now();
    Post announcement = Post(
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        title: "Post Title",
        summary: "Summary of the announcement to display in summary card.",
        coverImageUrl: "http://someurl.com/somepath",
        type: PostType.announcement,
        startDate: now.toString(),
        endDate: now.toString());

    expect(json.encode(announcement.toJson()),
        '{"title":"Post Title","body":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","coverImageUrl":"http://someurl.com/somepath","summary":"Summary of the announcement to display in summary card.","type":"announcement","startDate":"$now","endDate":"$now"}');
  });

  test('Deserialize Post', () {
    DateTime now = DateTime.now();
    Post announcement = Post(
        body: 'Lorem ipsum dolor sit amet,',
        title: "Post Title",
        summary: "Summary of the announcement to display in summary card.",
        coverImageUrl: "http://someurl.com/somepath",
        type: PostType.news,
        startDate: now.toString(),
        endDate: now.toString());

    Map<String, dynamic> data = json.decode(
        '{"title":"Post Title","body":"Lorem ipsum dolor sit amet,","coverImageUrl":"http://someurl.com/somepath","summary":"Summary of the announcement to display in summary card.","type":"news","startDate":"$now","endDate":"$now"}');

    expect(announcement.body, Post.fromJson(data).body);
    expect(announcement.title, Post.fromJson(data).title);
    expect(announcement.summary, Post.fromJson(data).summary);
    expect(announcement.coverImageUrl, Post.fromJson(data).coverImageUrl);
    expect(announcement.type, Post.fromJson(data).type);
    expect(announcement.startDate, Post.fromJson(data).startDate);
    expect(announcement.endDate, Post.fromJson(data).endDate);
  });

  test('Update Post', () {
    DateTime now = DateTime.now();
    Post announcement = Post(
        body: 'Lorem ipsum dolor sit amet,',
        title: "Post Title",
        summary: "Summary of the announcement to display in summary card.",
        coverImageUrl: "http://someurl.com/somepath",
        type: PostType.news,
        startDate: now.toString(),
        endDate: now.toString());

    announcement.title = announcement.title + " New";

    expect(announcement.title, "Post Title New");
    expect(announcement.coverImageUrl, "http://someurl.com/somepath");
  });
}
