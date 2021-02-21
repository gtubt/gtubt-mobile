import 'dart:convert';

import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/base.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class TicketFailure {
  final String message;

  TicketFailure(this.message);

  @override
  String toString() => message;
}

class TicketService extends BaseService {
  final servicePath = 'ticket';

  Future<Either<Ticket, TicketFailure>> get(User user) async {
    //  TODO: implement
  }

  Future<Either<Ticket, TicketFailure>> post(User user) async {
    //  TODO: implement
  }

  Future<Either<Ticket, TicketFailure>> patch(User user) async {
    //  TODO: implement
  }

  Future<Either<Ticket, TicketFailure>> delete(User user) async {
    //  TODO: implement
  }

  Future<Either<List<Ticket>, TicketFailure>> getAll(User user) async {
    // TODO: refactor me
    List<Ticket> _tickets = List();

    String url = '$baseUrl....';
    final response = await http.get('$url');

    if (response.statusCode == 200) {
      final apiResponse =
          ApiResponseList<Ticket>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        _tickets = apiResponse.body;
        return Left(_tickets);
      }
    }
    return Right(TicketFailure('Fetching failure!'));
  }
}
