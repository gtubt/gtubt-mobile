library event;

import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  String title;
  String description;
  String coverImageUrl;
  String date;

  Event({
    this.title,
    this.date,
    this.coverImageUrl,
    this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

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
