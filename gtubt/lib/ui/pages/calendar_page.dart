import 'package:GTUBT/ui/blocs/calendar_bloc/bloc.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CalendarPageBloc>(context).add(FetchEvents());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarPageBloc, CalendarPageState>(
      listener: (context, state) {},
      builder: (context, CalendarPageState state) {
        return Scaffold(
            backgroundColor: ColorSets.pageBackgroundColor,
            body: _buildBody(state));
      },
    );
  }

  Widget _buildBody(CalendarPageState state) {
    Widget body;
    if (state is EventsLoadingError) {
      body = Text('An Error Occur' // state.failure.toString()
          );
    }

    if (state is CalendarPageInitState || state is EventsLoading) {
      body = Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is EventsLoaded) {
      List<Event> events = state.events;
      body = ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          var event = events[index];
          var cardPadding = index == 0
              ? EdgeInsets.only(
                  left: 22.0, right: 22.0, bottom: 22.0, top: 22.0)
              : EdgeInsets.only(left: 22.0, right: 22.0, bottom: 22.0);

          return Padding(
            padding: cardPadding,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: ColorSets.profilePageThemeColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${event.date.day} ${months[event.date.month - 1]} ${event.date.year}\n",
                      style: TextStyles.subtitle1
                          .copyWith(color: ColorSets.lightTextColor),
                    ),
                    Text(
                      event.title,
                      style: TextStyles.headline6
                          .copyWith(color: ColorSets.lightTextColor),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    return body;
  }
}
