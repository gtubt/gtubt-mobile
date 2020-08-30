// GENERATED CODE - DO NOT MODIFY BY HAND

part of api_response;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return ApiResponse(
    status: json['Status'] as int,
    message: json['Message'] as String,
  );
}

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
    };

ApiResponseList<T> _$ApiResponseListFromJson<T>(Map<String, dynamic> json) {
  return ApiResponseList<T>(
    status: json['Status'] as int,
    message: json['Message'] as String,
    body: (json['Body'] as List)?.map(_Converter<T>().fromJson)?.toList(),
  );
}

Map<String, dynamic> _$ApiResponseListToJson<T>(ApiResponseList<T> instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Body': instance.body?.map(_Converter<T>().toJson)?.toList(),
    };

ApiResponseSingle<T> _$ApiResponseSingleFromJson<T>(Map<String, dynamic> json) {
  return ApiResponseSingle<T>(
    status: json['Status'] as int,
    message: json['Message'] as String,
    body: _Converter<T>().fromJson(json['Body']),
  );
}

Map<String, dynamic> _$ApiResponseSingleToJson<T>(
        ApiResponseSingle<T> instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Body': _Converter<T>().toJson(instance.body),
    };
