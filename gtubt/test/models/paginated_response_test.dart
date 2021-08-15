import 'dart:convert';

import 'package:GTUBT/models/event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/paginated_response.dart';

void main() {
  test('Deserialize Paginated Response', () {
    DateTime now = DateTime.now();
    Map<String, dynamic> data = json.decode('{"count": 1023, "next": "https://api.example.org/accounts/?limit=100&offset=500", "previous": "https://api.example.org/accounts/?limit=100&offset=300","results": [{"title":"Event Title","description":"Lorem ipsum dolor","coverImageUrl":"http://someurl.com/somepath","date":"$now", "createdDate":"$now"}, {"title":"Event Title 2","description":"Lorem ipsum dolor","coverImageUrl":"http://someurl.com/somepath","date":"$now", "createdDate":"$now"}]}');
    var response =  PaginatedResponse.fromJson(data);

    expect(response.results!.isNotEmpty, true);
    var events = response.results!.map((e) => Event.fromJson(e)).toList();
    expect(events.isNotEmpty, true);
  });
}