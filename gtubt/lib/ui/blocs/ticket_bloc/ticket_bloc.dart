import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/service/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class TicketPageBloc extends Bloc<TicketPageEvent, TicketPageState> {
  final UserService _userService = UserService();

  @override
  TicketPageState get initialState => TicketPageInitState();

  List<Ticket> pageTickets = [
    Ticket(
      title: "GeekDay 2020",
      name: "name1",
      location: "location1",
      date: DateTime(2020, 7, 13),
      codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg",
    ),
    Ticket(
        title: "GeekDay 2021",
        name: "name2",
        location: "location2",
        date: DateTime(2020, 7, 13),
        codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg"),
    Ticket(
        title: "GeekDay 2022",
        name: "name3",
        location: "location3",
        date: DateTime(2020, 7, 13),
        codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg"),
    Ticket(
        title: "GeekDay 2023",
        name: "name4",
        location: "location4",
        date: DateTime(2020, 7, 13),
        codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg"),
    Ticket(
        title: "GeekDay 2024",
        name: "name5",
        location: "location5",
        date: DateTime(2020, 7, 13),
        codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg"),
    Ticket(
        title: "GeekDay 2025",
        name: "name6",
        location: "location6",
        date: DateTime(2020, 7, 13),
        codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg")
  ];

  @override
  Stream<TicketPageState> mapEventToState(TicketPageEvent event) async* {
    if (event is FetchTickets) {
      yield* _mapFetchTicketsToState();
    }
  }

  Stream<TicketPageState> _mapFetchTicketsToState() async* {
    yield TicketsLoading();

    // TODO: call backend service method
    // TODO: _userService.getTickets();
    Future.delayed(Duration(seconds: 1));
    yield TicketsLoaded(tickets: pageTickets);
  }
}
