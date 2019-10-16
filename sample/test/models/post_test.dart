import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/post.dart';

void main() {
  test('Serialize Post', () {
    Post announcement = Post((announcement) => announcement
      ..body = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ..title = "Post Title"
      ..summary = "Summary of the announcement to display in summary card."
      ..coverImageUrl = "http://someurl.com/somepath");

    expect(announcement.toJson(),
      '{"title":"Post Title","body":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","coverImageUrl":"http://someurl.com/somepath","summary":"Summary of the announcement to display in summary card."}');
  });

  test('Deserialize Post', () {
    Post announcement = Post((announcement) => announcement
      ..body = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ..title = "Post Title"
      ..summary = "Summary of the announcement to display in summary card."
      ..coverImageUrl = "http://someurl.com/somepath");

    expect(announcement,
      Post.fromJson('{"title":"Post Title","body":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","coverImageUrl":"http://someurl.com/somepath","summary":"Summary of the announcement to display in summary card."}'));
  });

  test('Update Post', () {
    Post announcement = Post((announcement) => announcement
      ..body = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ..title = "Post Title"
      ..summary = "Summary of the announcement to display in summary card."
      ..coverImageUrl = "http://someurl.com/somepath");

    announcement = announcement.rebuild((b) => b
    ..title = announcement.title + " New");

    expect(announcement.title, "Post Title New");
    expect(announcement.coverImageUrl, "http://someurl.com/somepath");
  });
}