import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/service/ticket.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

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

  TicketsLoaded({@required this.tickets});

  @override
  List<Object> get props => [];
}

class TicketsLoadingError extends TicketPageState {
  final TicketFailure failure;

  TicketsLoadingError(this.failure);

  @override
  List<Object> get props => [failure];
}
