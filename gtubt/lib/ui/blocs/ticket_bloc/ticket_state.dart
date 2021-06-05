import 'package:GTUBT/models/ticket.dart';
import 'package:equatable/equatable.dart';

abstract class TicketPageState extends Equatable {}

class TicketPageInitState extends TicketPageState {
  @override
  List<Object> get props => [];
}

class TicketsLoading extends TicketPageState {
  @override
  List<Object> get props => [];
}

class TicketsLoaded extends TicketPageState {
  final List<Ticket> tickets;

  TicketsLoaded({required this.tickets});

  @override
  List<Object> get props => [];
}

class TicketsError extends TicketPageState {
  final String message;

  TicketsError(this.message);

  @override
  List<Object> get props => [message];
}
