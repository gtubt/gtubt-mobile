import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/service/event.dart';
import 'package:GTUBT/service/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:GTUBT/ui/blocs/calendar_bloc/bloc.dart';

class CalendarPageBloc extends Bloc<CalendarPageEvent, CalendarPageState> {
  //final UserService _userService = UserService();
  final EventService _eventService = EventService();

  CalendarPageBloc() : super(CalendarPageInitState());

  List<Event> pageEvents = [
    Event(
      title: "Game Workshop First Lesson: Introduction",
      description: "location1",
      date: DateTime(2021, 8, 20),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "Alumni Meeting 2021",
      description: "location1",
      date: DateTime(2021, 8, 20),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "Software Development Lifecycles",
      description: "location1",
      date: DateTime(2021, 8, 21),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "Bilişim Vadisi Teknik Gezisi",
      description: "location1",
      date: DateTime(2021, 9, 22),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "Güvenlik Görevlileri Konseri",
      description: "location1",
      date: DateTime(2021, 9, 22),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "Kriptoloji Yarışması #1",
      description: "location1",
      date: DateTime(2021, 9, 22),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "Tanışma Toplantısı",
      description: "location1",
      date: DateTime(2021, 9, 23),
      coverImageUrl:
          "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Event(
      title: "Yönetim Kurulu Seçimi",
      description: "location1",
      date: DateTime(2021, 9, 23),
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
    // TODO: call backend service method
    // TODO: _userService.getEvents();
    //if(error) yield EventsLoadingError
    try {
      print("_mapFetchEventsToState");
      yield EventsLoading();
      final List<Event> pageEvents = await _eventService.getAll();
      print("events:${pageEvents}");
      print("len:${pageEvents.length}");
      yield EventsLoaded(events: pageEvents);
    } catch (e) {
      print(e.toString());
      yield EventsError("could not retrieve data");
    }
  }
}
