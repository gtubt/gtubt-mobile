// GENERATED CODE - DO NOT MODIFY BY HAND

part of event;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    title: json['title'] as String,
    date: json['date'] as String,
    coverImageUrl: json['coverImageUrl'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'coverImageUrl': instance.coverImageUrl,
      'date': instance.date,
    };
