library ticket;

import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  String title;
  String name;
  String location;
  DateTime date;
  String codeUrl;

  Ticket({this.title, this.name, this.location, this.date, this.codeUrl});

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  String toString() {
    return '''Ticket {
    Title: $title,
    Name: $name,
    Location: $location,
    Date: $date,
    codeUrl: $codeUrl
}''';
  }
}