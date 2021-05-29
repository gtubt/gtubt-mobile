import 'package:GTUBT/exceptions/event.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/service/service.dart';
import 'dart:convert';

class EventService extends BaseService {
  static final EventService _eventService = EventService._internal();
  final servicePath = 'events';
  EventService._internal();

  factory EventService() {
    return _eventService;
  }

  Future<List<Event>> getAll() async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/all/';
    print(url);
    final response = await GET('$url');
    print("getAll body response.body ${response.body}");
    print('response:::::${response.statusCode}');

    if (response.statusCode != 200) {
      throw EventException("    if (response.statusCode != 200) {");
    }
    try {
      print("try içi");
      final apiResponse =
          ApiResponseList<Event>.fromJson(json.decode(response.body));
      print(apiResponse.body);
      print('apiResponse:::::${apiResponse.status}');

      if (apiResponse.status != 200) {
        throw EventException.message('ne message ? ${apiResponse.message}');
      }
      return apiResponse.body;
    } catch (e) {
      throw EventException("the last catch ${e.toString()}");
    }
  }

  Future<Event> delete(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await DELETE('$url');

    if (response.statusCode != 200) {
      throw EventException();
    }
    try {
      final apiResponse =
          ApiResponseSingle<Event>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw EventException.message('${apiResponse.message}');
      }
      return apiResponse.body;
    } catch (_) {
      throw EventException();
    }
  }

  Future<Event> patch(Event event) async {
    var id = event.id;
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';
    try {
      var eventJson = event.toJson();
      var bodyData = json.encode(eventJson);

      final response = await PATCH('$url',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData);

      if (response.statusCode != 200) {
        throw EventException();
      }

      final apiResponse =
          ApiResponseSingle<Event>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw EventException.message(apiResponse.message);
      }

      return apiResponse.body;
    } catch (_) {
      throw EventException();
    }
  }

  Future<Event> get(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await GET('$url');

    if (response.statusCode != 200) {
      throw EventException();
    }
    try {
      final apiResponse =
          ApiResponseSingle<Event>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw EventException.message(apiResponse.message);
      }

      return apiResponse.body;
    } catch (_) {
      throw EventException();
    }
  }
}
