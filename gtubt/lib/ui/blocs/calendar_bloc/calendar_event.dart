import 'package:equatable/equatable.dart';

abstract class CalendarPageEvent extends Equatable {}

class FetchEvents extends CalendarPageEvent {
  @override
  List<Object> get props => [];
}
