import 'dart:convert';

import 'package:GTUBT/service/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/post.dart';

void main() {
  test('Get Post With ID', () async {
    Post post = await PostService().get("TEST_POST_DONT_DELETE");
    expect(post == null, false);
    expect(post.type, PostType.news);
    expect(post.title, "TEST_TITLE");
    expect(post.summary, "TEST_SUMMARY");
    expect(post.body, "TEST_BODY");
  });
}