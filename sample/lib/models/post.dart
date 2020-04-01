library post;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:GTUBT/models/core/serializers.dart';

part 'post.g.dart';

abstract class Post implements Built<Post, PostBuilder> {
  String get title;
  String get body;
  String get coverImageUrl;
  String get summary;
  PostType get type;
  String get startDate;
  String get endDate;

  Post._();

  factory Post([updates(PostBuilder b)]) = _$Post;

  String toJson() {
    return json.encode(serializers.serializeWith(Post.serializer, this));
  }

  static Post fromJson(String jsonString) {
    return serializers.deserializeWith(Post.serializer, json.decode(jsonString));
  }

  static Serializer<Post> get serializer => _$postSerializer;

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

class PostType extends EnumClass {
  static const PostType announcement = _$announcement;
  static const PostType news = _$news;

  const PostType._(String name) : super(name);

  static BuiltSet<PostType> get values => _$values;
  static PostType valueOf(String name) => _$valueOf(name);

  static Serializer<PostType> get serializer => _$postTypeSerializer;
}