import 'package:GTUBT/models/event.dart';
import 'package:equatable/equatable.dart';

abstract class CalendarPageState extends Equatable {}

class CalendarPageInitState extends CalendarPageState {
  @override
  List<Object> get props => [];
}

class EventsLoading extends CalendarPageState {
  @override
  List<Object> get props => [];
}

class EventsLoaded extends CalendarPageState {
  final List<Event> events;

  EventsLoaded({required this.events});

  @override
  List<Object> get props => [];
}

class EventsError extends CalendarPageState {
  final String message;

  EventsError(this.message);

  @override
  List<Object> get props => [message];
}
