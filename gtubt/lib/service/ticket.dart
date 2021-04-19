import 'dart:convert';

import 'package:GTUBT/exceptions/ticket.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/service.dart';

class TicketService extends BaseService {
  final servicePath = 'ticket';

  Future<Ticket> get(User user) async {
    //  TODO: implement
  }

  Future<Ticket> post(User user) async {
    //  TODO: implement
  }

  Future<Ticket> patch(User user) async {
    //  TODO: implement
  }

  Future<Ticket> delete(User user) async {
    //  TODO: implement
  }

  Future<List<Ticket>> getAll(User user) async {
    // FIXME
    List<Ticket> _tickets = List();

    String url = '$baseUrl....';
    final response = await GET('$url');

    if (response.statusCode != 200) {
      throw TicketException();
    }
    try {
      final apiResponse =
          ApiResponseList<Ticket>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw TicketException.message(apiResponse.message);
      }
      _tickets = apiResponse.body;
      return _tickets;
    } catch (_) {
      throw TicketException();
    }
  }
}
