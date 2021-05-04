import 'package:GTUBT/exceptions/ticket.dart';
import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/service/ticket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class TicketPageBloc extends Bloc<TicketEvent, TicketPageState> {
  final TicketService _ticketService = TicketService();

  TicketPageBloc() : super(TicketPageInitState());

  @override
  Stream<TicketPageState> mapEventToState(TicketEvent event) async* {
    if (event is FetchTickets) {
      yield* _mapFetchTicketsToState();
    }
  }

  Stream<TicketPageState> _mapFetchTicketsToState() async* {
    yield TicketsLoading();
    try {
      List<Ticket> tickets = await _ticketService.getAll();
      yield TicketsLoaded(tickets: tickets);
    } on TicketException catch (err) {
      yield TicketsError(err.message);
    }
  }
}
