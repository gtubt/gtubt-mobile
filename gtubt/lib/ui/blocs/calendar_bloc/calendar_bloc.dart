import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/service/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GTUBT/ui/blocs/calendar_bloc/bloc.dart';

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
    // TODO: call backend service method
    // TODO: _userService.getEvents();
    //if(error) yield EventsLoadingError
    try {
      yield EventsLoading();
      final List<Event> pageEvents = await _eventService.getAll();
      yield EventsLoaded(events: pageEvents);
    } catch (e) {
      yield EventsError("could not retrieve data");
    }
  }
}
