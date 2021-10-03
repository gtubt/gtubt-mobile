import 'dart:convert';

import 'package:GTUBT/exceptions/event.dart';
import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/models/paginated_response.dart';
import 'package:GTUBT/service/service.dart';

class EventService extends BaseService {
  static final EventService _eventService = EventService._internal();
  final servicePath = 'events';

  EventService._internal();

  factory EventService() {
    return _eventService;
  }

  Future<List<Event?>?> list() async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/';
    final response = await GET(url);
    if (response.statusCode != 200) {
      throw EventException();
    }
    try {
      List<Event> body = [];
      PaginatedResponse paginatedResponse =
          PaginatedResponse.fromJson(json.decode(response.body));
      body = paginatedResponse.results!.map((e) => Event.fromJson(e)).toList();
      return body;
    } on EventException catch (ex) {
      throw EventException(ex.message);
    } catch (_) {
      throw EventException();
    }
  }

  Future<Event?> delete(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await DELETE(url);
    if (response.statusCode != 200) {
      throw EventException();
    }
    try {
      final event = Event.fromJson(json.decode(response.body));
      return event;
    } on EventException catch (ex) {
      throw EventException(ex.message);
    } catch (_) {
      throw EventException();
    }
  }

  Future<Event?> patch(Event event) async {
    var id = event.id;
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';
    try {
      var eventJson = event.toJson();
      var bodyData = json.encode(eventJson);

      final response = await PATCH(url, body: bodyData);

      if (response.statusCode != 200) {
        throw EventException();
      }

      final apiResponse = Event.fromJson(json.decode(response.body));

      return apiResponse;
    } on EventException catch (ex) {
      throw EventException(ex.message);
    } catch (_) {
      throw EventException();
    }
  }

  Future<Event?> get(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await GET(url);

    if (response.statusCode != 200) {
      throw EventException();
    }
    try {
      final apiResponse = Event.fromJson(json.decode(response.body));

      return apiResponse;
    } on EventException catch (ex) {
      throw EventException(ex.message);
    } catch (_) {
      throw EventException();
    }
  }
}
