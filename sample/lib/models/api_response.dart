library api_response;

import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  @JsonKey(name: 'Status')
  int status;
  
  @JsonKey(name: 'Message')
  String message;

  ApiResponse({
    this.status,
    this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  @override
  String toString() {
    return '''ApiResponse {
    Status: $status,
    Message: $message,
}''';
  }
}


@JsonSerializable()
class ApiResponseList<T> extends ApiResponse {
  @JsonKey(name: 'Body')
  @_Converter()
  List<T> body;

  ApiResponseList({
    int status, String message,
    this.body,
  }) : super(status: status, message: message);

  factory ApiResponseList.fromJson(Map<String, dynamic> json) => _$ApiResponseListFromJson(json);

  @override
  String toString() {
    return '''ApiResponse {
    Status: $status,
    Message: $message,
    Body: $body
}''';
  }
}

@JsonSerializable()
class ApiResponseSingle<T> extends ApiResponse {
  @JsonKey(name: 'Body')
  @_Converter()
  T body;

  ApiResponseSingle({
    int status, String message,
    this.body,
  }) : super(status: status, message: message);

  factory ApiResponseSingle.fromJson(Map<String, dynamic> json) => _$ApiResponseSingleFromJson(json);

  @override
  String toString() {
    return '''ApiResponse {
    Status: $status,
    Message: $message,
    Body: $body
}''';
  }
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('name') &&
        json.containsKey('lastname')) {
      return User.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> &&
        json.containsKey('title') &&
        json.containsKey('description')) {
      return Event.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> &&
        json.containsKey('title') &&
        json.containsKey('summary')) {
      return Post.fromJson(json) as T;
    }

    return json as T;
  }

  dynamic modelDeserializer(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('name') &&
        json.containsKey('lastName')) {
      return User.fromJson(json);
    }

    if (json is Map<String, dynamic> &&
        json.containsKey('title') &&
        json.containsKey('description')) {
      return Event.fromJson(json);
    }

    if (json is Map<String, dynamic> &&
        json.containsKey('title') &&
        json.containsKey('summary')) {
      return Post.fromJson(json);
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}