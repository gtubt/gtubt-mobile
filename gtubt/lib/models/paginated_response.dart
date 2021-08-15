library paginated_response;

import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

@JsonSerializable()
class PaginatedResponse {
  int? count;
  String? previous;
  String? next;
  List<Map<String, dynamic>>? results;


  PaginatedResponse({this.count, this.previous, this.next, this.results});

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedResponseToJson(this);

  @override
  String toString() {
    return '''PaginatedResponse {
    count: $count, 
    previous: $previous, 
    ne+xt: $next, 
    results: $results
}''';
  }
}
