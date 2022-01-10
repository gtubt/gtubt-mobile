import 'dart:convert';

import 'package:GTUBT/exceptions/ticket.dart';
import 'package:GTUBT/models/paginated_response.dart';
import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/service.dart';

class TicketService extends BaseService {
  final servicePath = 'ticket';

  Future<Ticket?> get(User user) async {
    //  TODO: implement
  }

  Future<Ticket?> post(User user) async {
    //  TODO: implement
  }

  Future<Ticket?> patch(User user) async {
    //  TODO: implement
  }

  Future<Ticket?> delete(User user) async {
    //  TODO: implement
  }

  Future<List<Ticket?>?> list(User user) async {
    // FIXME
    List<Ticket?>? _tickets = [];

    String url = '$baseUrl....';
    final response = await GET(url);

    if (response.statusCode != 200) {
      throw TicketException();
    }
    try {
      PaginatedResponse paginatedResponse = PaginatedResponse.fromJson(json.decode(response.body));
      List<Ticket> body = paginatedResponse.results!.map((e) => Ticket.fromJson(e)).toList();
      return body;
    } catch (_) {
      throw TicketException();
    }
  }
}
