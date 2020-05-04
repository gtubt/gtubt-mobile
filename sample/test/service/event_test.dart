import 'dart:convert';

import 'package:GTUBT/service/event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/event.dart';

void main() {
  test('Get Event with an ID', () async {
    Event event = await EventService().get("Yehhjj8nYOLavI22uQpR");
    expect(event == null, false);
    expect(event.title, "Career Days");
  });
}
