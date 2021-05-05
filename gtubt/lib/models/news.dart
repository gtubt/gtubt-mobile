library news;

import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  int? id;
  String? title;
  String? body;
  String? coverImageUrl;
  String? summary;
  NewsType? type;
  DateTime? startDate;
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

  Map<String, dynamic> toJson() => _$NewsToJson(this);

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
