import 'package:GTUBT/exceptions/ticket.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/service/service.dart';
import 'dart:convert';

class TicketService extends BaseService {
  static final TicketService _ticketService = TicketService._internal();
  final servicePath = 'tickets';
  TicketService._internal();

  factory TicketService() {
    return _ticketService;
  }

  Future<List<Ticket>> getAll() async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/all';

    final response = await GET('$url');

    if (response.statusCode != 200) {
      throw TicketException();
    }
    try {
      List<Ticket> body = [];
      final ticketList = json.decode(response.body);
      ticketList.forEach((ticket) {
        body.add(Ticket.fromJson(ticket));
      });

      return body.reversed.toList();
    } catch (err) {
      print(err);
      throw TicketException();
    }
  }

  Future<Ticket> get(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await GET('$url');
    if (response.statusCode != 200) {
      throw TicketException();
    }
    try {
      final apiResponse =
          ApiResponseSingle<Ticket>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw TicketException.message(apiResponse.message);
      }
      return apiResponse.body;
    } catch (e) {
      throw TicketException();
    }
  }

  Future<Ticket> post(Ticket ticket) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath';
    try {
      var ticketInJson = ticket.toJson();
      var bodyData = json.encode(ticketInJson);

      final response = await POST('$url',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData);
      if (response.statusCode != 200) {
        throw TicketException();
      }

      final apiResponse =
          ApiResponseSingle.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw TicketException.message(apiResponse.message);
      }
      return apiResponse.body;
    } catch (_) {
      throw TicketException();
    }
  }

  Future<Ticket> patch(Ticket ticket) async {
    var id = ticket.id;
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';
    try {
      var ticketJson = ticket.toJson();
      var bodyData = json.encode(ticketJson);

      final response = await PATCH('$url',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData);

      if (response.statusCode != 200) {
        throw TicketException();
      }

      final apiResponse =
          ApiResponseSingle<Ticket>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw TicketException.message(apiResponse.message);
      }

      return apiResponse.body;
    } catch (_) {
      throw TicketException();
    }
  }

  Future<Ticket> delete(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await DELETE('$url');

    if (response.statusCode != 200) {
      throw TicketException();
    }
    try {
      final apiResponse =
          ApiResponseSingle<Ticket>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw TicketException.message(apiResponse.message);
      }
      return apiResponse.body;
    } catch (_) {
      throw TicketException();
    }
  }
}
