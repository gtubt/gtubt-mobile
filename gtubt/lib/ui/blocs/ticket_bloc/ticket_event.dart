import 'package:equatable/equatable.dart';

abstract class TicketPageEvent extends Equatable{}

class FetchTickets extends TicketPageEvent {

  @override
  List<Object> get props => [];
}
