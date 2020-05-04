// GENERATED CODE - DO NOT MODIFY BY HAND

part of post;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    title: json['title'] as String,
    body: json['body'] as String,
    coverImageUrl: json['coverImageUrl'] as String,
    summary: json['summary'] as String,
    type: _$enumDecodeNullable(_$PostTypeEnumMap, json['type']),
    startDate: json['startDate'] as String,
    endDate: json['endDate'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'coverImageUrl': instance.coverImageUrl,
      'summary': instance.summary,
      'type': _$PostTypeEnumMap[instance.type],
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PostTypeEnumMap = {
  PostType.announcement: 'announcement',
  PostType.news: 'news',
};
