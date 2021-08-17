library news;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  int? id;
  String? title;
  String? body;

  @JsonKey(name: 'cover_image_url')
  String? coverImageUrl;
  String? summary;

  @JsonKey(fromJson: _stringToNewsType, toJson: _newsTypeToString)
  NewsType? type;

  @JsonKey(
    name: 'start_date',
    fromJson: _stringToDateTime,
    toJson: _dateTimeToString,
  )
  DateTime? startDate;

  @JsonKey(
    name: 'end_date',
    fromJson: _stringToDateTime,
    toJson: _dateTimeToString,
  )
  DateTime? endDate;

  News({
    this.id,
    this.title,
    this.body,
    this.coverImageUrl,
    this.summary,
    this.type,
    this.startDate,
    this.endDate,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String?, dynamic> toJson() => _$NewsToJson(this);

  static DateTime? _stringToDateTime(String? dateTime) {
    if (dateTime != null) return DateTime.parse(dateTime);
  }

  static String? _dateTimeToString(DateTime? dateTime) {
    if (dateTime != null) {
      final dateFormatter = DateFormat('y-M-ddTH:m:s.Z');
      return dateFormatter.format(dateTime);
    }
  }

  static NewsType? _stringToNewsType(String? newsType) {
    if (newsType != null) {
      return NewsType.values
          .firstWhere((element) => describeEnum(element) == newsType);
    }
  }

  static String? _newsTypeToString(NewsType? newsType) {
    return newsType.toString();
  }

  @override
  String toString() {
    return '''User {  
    Title: $title,
    Summary: $summary,
    Body: $body,
    Start Date: $startDate,
    End Date: $endDate,
    Type: $type,
    CoverUrl: $coverImageUrl
}''';
  }
}

enum NewsType { announcement, news }
