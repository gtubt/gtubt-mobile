library post;

import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  int id;
  String title;
  String body;
  String coverImageUrl;
  String summary;
  PostType type;
  DateTime startDate;
  DateTime endDate;

  Post({
    this.id,
    this.title,
    this.body,
    this.coverImageUrl,
    this.summary,
    this.type,
    this.startDate,
    this.endDate,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

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

enum PostType { announcement, news }
