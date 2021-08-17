import 'package:GTUBT/exceptions/event.dart';
import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/service/event.dart';
import 'package:GTUBT/ui/blocs/calendar_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPageBloc extends Bloc<CalendarPageEvent, CalendarPageState> {
  final EventService _eventService = EventService();

  CalendarPageBloc() : super(CalendarPageInitState());

  @override
  Stream<CalendarPageState> mapEventToState(CalendarPageEvent event) async* {
    if (event is FetchEvents) {
      yield* _mapFetchEventsToState();
    }
  }

  Stream<CalendarPageState> _mapFetchEventsToState() async* {
    try {
      yield EventsLoading();
      List<Event?>? pageEvents = (await _eventService.list());
      yield EventsLoaded(events: pageEvents);
    } on EventException catch (e) {
      yield EventsError(e.message);
    }
  }
}
