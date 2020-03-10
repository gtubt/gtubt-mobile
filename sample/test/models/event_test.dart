import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/event.dart';

void main() {
  test('Serialize Event', () {
    DateTime now = DateTime.now();
    Event announcement = Event((announcement) => announcement
      ..description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ..title = "Event Title"
      ..date = now.toString()
      ..coverImageUrl = "http://someurl.com/somepath");

    expect(announcement.toJson(),
      '{"title":"Event Title","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","coverImageUrl":"http://someurl.com/somepath","date":"$now"}');
  });

  test('Deserialize Event', () {
    DateTime now = DateTime.now();
    Event announcement = Event((announcement) => announcement
      ..description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ..title = "Event Title"
      ..date = now.toString()
      ..coverImageUrl = "http://someurl.com/somepath");

    expect(announcement,
      Event.fromJson('{"title":"Event Title","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","coverImageUrl":"http://someurl.com/somepath","date":"$now"}'));
  });

  test('Update Event', () {
    DateTime now = DateTime.now();
    Event announcement = Event((announcement) => announcement
      ..description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ..title = "Event Title"
      ..date = now.toString()
      ..coverImageUrl = "http://someurl.com/somepath");

    now = DateTime.now();
    announcement = announcement.rebuild((b) => b
    ..date = now.toString());

    expect(announcement.date, now.toString());
    expect(announcement.coverImageUrl, "http://someurl.com/somepath");
  });
}