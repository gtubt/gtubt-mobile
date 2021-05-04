import 'package:equatable/equatable.dart';

abstract class TicketEvent extends Equatable {
  TicketEvent() : super();
}

class FetchTickets extends TicketEvent {
  FetchTickets() : super();

  @override
  String toString() {
    return 'Tickets are being refreshed';
  }

  @override
  List<Object> get props => [];
}
