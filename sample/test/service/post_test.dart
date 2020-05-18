import 'dart:convert';

import 'package:GTUBT/service/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/post.dart';

void main() {
  test('Get Post With ID', () async {
    Post post = await PostService().get("U2r7vhZEbwhtMlytDgr0");
    expect(post == null, false);
    expect(post.type, "announcement");
    expect(post.title, "A Post");
    expect(post.body, "some event, some stuff and more...");
  });
}