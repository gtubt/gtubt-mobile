import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/event.dart';

void main() {
  test('Serialize Event', () {
    DateTime now = DateTime.now();
    Event announcement = Event(
        date: now.toString(),
        title: 'Event Title',
        coverImageUrl: "http://someurl.com/somepath",
        description: 'Lorem ipsum');

    expect(json.encode(announcement.toJson()),
        '{"title":"Event Title","description":"Lorem ipsum","coverImageUrl":"http://someurl.com/somepath","date":"$now"}');
  });

  test('Deserialize Event', () {
    DateTime now = DateTime.now();
    Event announcement = Event(
      description: 'Lorem ipsum dolor',
      title: 'Event Title',
      date: now.toString(),
      coverImageUrl: 'http://someurl.com/somepath',
    );
    Map<String, dynamic> data = json.decode(
        '{"title":"Event Title","description":"Lorem ipsum dolor","coverImageUrl":"http://someurl.com/somepath","date":"$now"}');

    expect(announcement.description, Event.fromJson(data).description);
    expect(announcement.title, Event.fromJson(data).title);
    expect(announcement.date, Event.fromJson(data).date);
    expect(announcement.coverImageUrl, Event.fromJson(data).coverImageUrl);

  });

  test('Update Event', () {
    DateTime now = DateTime.now();
    Event announcement = Event(
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      title: "Event Title",
      date: now.toString(),
      coverImageUrl: "http://someurl.com/somepath");

    now = DateTime.now();
    announcement.date = now.toString();

    expect(announcement.date, now.toString());
    expect(announcement.coverImageUrl, "http://someurl.com/somepath");
  });
}
