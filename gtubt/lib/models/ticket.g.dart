// GENERATED CODE - DO NOT MODIFY BY HAND

part of ticket;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return Ticket(
    title: json['title'] as String,
    name: json['name'] as String,
    location: json['location'] as String,
    date: json['date'] as String,
    hour: json['hour'] as String,
    codeUrl: json['codeUrl'] as String,
  );
}

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
  'title': instance.title,
  'name': instance.name,
  'location': instance.location,
  'date': instance.date,
  'hour': instance.hour,
  'codeUrl': instance.codeUrl,
};
