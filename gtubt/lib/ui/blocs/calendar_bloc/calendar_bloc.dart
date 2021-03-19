import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/service/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class CalendarPageBloc extends Bloc<CalendarPageEvent, CalendarPageState> {
  final UserService _userService = UserService();

  @override
  CalendarPageState get initialState => CalendarPageInitState();

  List<Event> pageEvents = [
    Event(
      title: "GeekDay 2020",
      description: "location1",
      date: DateTime(2020, 7, 13),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "GeekDay 2021",
      description: "location1",
      date: DateTime(2020, 7, 13),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "GeekDay 2022",
      description: "location1",
      date: DateTime(2020, 7, 13),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "GeekDay 2023",
      description: "location1",
      date: DateTime(2020, 7, 13),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
  ];

  @override
  Stream<CalendarPageState> mapEventToState(CalendarPageEvent event) async* {
    if (event is FetchEvents) {
      yield* _mapFetchEventsToState();
    }
  }

  Stream<CalendarPageState> _mapFetchEventsToState() async* {
    yield EventsLoading();

    // TODO: call backend service method
    // TODO: _userService.getEvents();
    //if(error) yield EventsLoadingError
    Future.delayed(Duration(seconds: 1));
    yield EventsLoaded(events: pageEvents);
  }
}
