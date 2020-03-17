library event;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:GTUBT/models/core/serializers.dart';

part 'event.g.dart';

abstract class Event implements Built<Event, EventBuilder> {
  String get title;
  String get description;
  String get coverImageUrl;
  String get date;

  Event._();

  factory Event([updates(EventBuilder b)]) = _$Event;

  String toJson() {
    return json.encode(serializers.serializeWith(Event.serializer, this));
  }

  static Event fromJson(String jsonString) {
    return serializers.deserializeWith(Event.serializer, json.decode(jsonString));
  }

  static Serializer<Event> get serializer => _$eventSerializer;

  @override
  String toString() {
    return '''Event {  
    Title: $title,
    Summary: $description,
    Date: $date,
    CoverUrl: $coverImageUrl
}''';
  }
}