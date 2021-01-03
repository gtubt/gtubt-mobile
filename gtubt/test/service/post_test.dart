import 'package:GTUBT/service/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/post.dart';
import 'package:http/http.dart' as http;

void main() {
  test('ENDPOINT=POSTS METHOD=GET URL=/posts', () async {
    var result = await PostService().getAll();
    List<Post> posts = result.fold(
            (posts) => posts,
            (postFailure) => null
    );
    expect(posts == null, false);
    expect(posts.length > 0, true);
  });

  test('ENDPOINT=POSTS METHOD=GET URL=/posts/(id)', () async {
    var result = await PostService().get("TEST_POST_DONT_DELETE");
    Post post = result.fold(
            (post) => post,
            (postFailure) => null
    );
    expect(post == null, false);
    expect(post.type, PostType.news);
    expect(post.title, "TEST_TITLE");
    expect(post.summary, "TEST_SUMMARY");
    expect(post.body, "TEST_BODY");
  });

  test('ENDPOINT=POSTS METHOD=POST URL=/posts', () async {
    Post post = new Post();
    post.title = "TEST_NEW_POST_TITLE";
    post.body = "TEST_NEW_POST_BODY";
    post.coverImageUrl = "TEST_NEW_POST_COVER_IMAGE_URL";
    post.summary = "TEST_NEW_POST_SUMMARY";
    post.type = PostType.news;
    post.startDate = DateTime(2020, 7, 13, 15, 30);
    post.endDate = DateTime(2020, 7, 13, 15, 30);
    http.Response response = await PostService().post(post);
    expect(response.statusCode == 200, true);
  });
}
