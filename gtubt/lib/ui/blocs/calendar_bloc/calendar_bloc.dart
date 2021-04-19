import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/service/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:GTUBT/ui/blocs/calendar_bloc/bloc.dart';

class CalendarPageBloc extends Bloc<CalendarPageEvent, CalendarPageState> {
  final UserService _userService = UserService();

  @override
  CalendarPageState get initialState => CalendarPageInitState();

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
    yield EventsLoading();

    // TODO: call backend service method
    // TODO: _userService.getEvents();
    //if(error) yield EventsLoadingError
    Future.delayed(Duration(seconds: 1));
    yield EventsLoaded(events: pageEvents);
  }
}
