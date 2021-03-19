import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/service/event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

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

  EventsLoaded({@required this.events});

  @override
  List<Object> get props => [];
}

class EventsLoadingError extends CalendarPageState {
  final EventFailure failure;

  EventsLoadingError(this.failure);

  @override
  List<Object> get props => [failure];
}
