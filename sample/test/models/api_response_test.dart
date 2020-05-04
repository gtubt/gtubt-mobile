import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/event.dart';

void main() {
  test('Deserialize Event', () {
    Map<String, dynamic> data = json.decode(
        '{"Body":[{"title":"Some Event","coverImageUrl":"","description":"something is going to happen...","date":"12/12/1999","id":"DaKONdgWyXl0eMVslQSt"},{"description":"we will feast!","date":"12/12/1999","id":"JlhujcKnR5wpwbgTJRYe","coverImageUrl":"https://firebasestorage.googleapis.com/v0/b/gtubtmobile-bb186.appspot.com/o/event_photos%2FJlhujcKnR5wpwbgTJRYe%2Fmangal.png?alt=media","title":"Mangal!"},{"description":"Companies will visit our school to talk to you people about careers","date":"12/12/1999","id":"Yehhjj8nYOLavI22uQpR","title":"Career Days","coverImageUrl":"https://avatars3.githubusercontent.com/u/6"}],"Message":"All events received","Status":200}');

    ApiResponseList<Event> resp = ApiResponseList.fromJson(data);
    expect(resp.status, 200);
    expect(resp.body == null, false);
  });
}
