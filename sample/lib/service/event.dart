import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/service/base.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventService extends BaseService{
  static final EventService _eventService = EventService._internal();
  
  EventService._internal();

  factory EventService() {
    return _eventService;
  }

  Future<List<Event>> getAll() async {
    String url = '$baseUrl/$endpointPrefix/event';
    
    final response = await http.get('$url');

    if (response.statusCode == 200) {
      final apiResponse = ApiResponseList<Event>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        return apiResponse.body;
      }
    }

    return List<Event>();
  }

  Future<Event> get(String id) async {
    String url = '$baseUrl/$endpointPrefix/event/$id';
    
    final response = await http.get('$url');

    if (response.statusCode == 200) {
      final apiResponse = ApiResponseSingle<Event>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        return apiResponse.body;
      }
    }

    return null;
  }
}