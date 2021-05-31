import 'package:GTUBT/ui/blocs/calendar_bloc/bloc.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GTUBT/ui/utils/constants.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var months = Constants.months;
  var days = Constants.daysShort;
  var colors = [
    Color(0xFFCA4F4B),
    Color(0xFFCBB14E),
    Color(0xFFD87E4A),
    Color(0xFF4DCA93),
    Color(0xFFC04CCA),
    Color(0xFF99CC4D),
    Color(0xFF4DADCC),
  ];

  @override
  void initState() {
    super.initState();
    context.read<CalendarPageBloc>().add(FetchEvents());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarPageBloc, CalendarPageState>(
      listener: (context, state) {
        if (state is EventsError) {
          NotificationFactory.errorFactory(message: state.message)
              .show(context);
        }
      },
      builder: (context, CalendarPageState state) {
        return Scaffold(
            backgroundColor: ColorSets.pageBackgroundColor,
            body: _buildBody(state));
      },
      buildWhen: (CalendarPageState previous, CalendarPageState current) {
        return current is! EventsError;
      },
    );
  }

  Widget _buildCalendar(List<Event?>? events) {
    int length = events!.length;
    return ListView.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        var cardPadding = EdgeInsets.zero;

        var event = events[index];
        var month = event!.date!.month;
        var day = event.date!.day;
        Widget monthHeader = Container();
        Widget dayHeader = Container();

        /* check next event until last item */
        if (index + 1 != length) {
          var nextEvent = events[index + 1];
          var nextMonth = nextEvent!.date!.month;
          var nextDay = nextEvent.date!.day;
          var nextWeekday = days[nextEvent.date!.weekday - 1];

          if (index == 0 || nextMonth != month) {
            cardPadding = EdgeInsets.only(top: 22.0);
            monthHeader = _monthHeader(months[nextMonth - 1]);
          }
          if (index == 0 || nextDay != day) {
            cardPadding = EdgeInsets.only(top: 22.0);
            dayHeader = _dayHeader(nextDay, nextWeekday);
          }
        }

        return Padding(
          padding: cardPadding,
          child: Column(
            children: [
              monthHeader,
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(
                    flex: 2,
                  ),
                  Expanded(
                    flex: 8,
                    child: dayHeader,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 54,
                    child: _buildEventCard(event.title!, colors[index % 7]),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildEventCard(String title, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
        child: Text(
          title,
          style: TextStyles.subtitle1.copyWith(color: ColorSets.lightTextColor),
        ),
      ),
    );
  }

  Widget _dayHeader(int day, String weekday) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "$day\n",
            style: TextStyles.headline4
                .copyWith(color: ColorSets.defaultTextColor),
          ),
          TextSpan(
            text: weekday,
            style: TextStyles.headline5
                .copyWith(color: ColorSets.defaultTextColor),
          ),
        ],
      ),
    );
  }

  Widget _monthHeader(String month) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        month,
        style: TextStyles.subtitle1.copyWith(color: ColorSets.defaultTextColor),
      ),
    );
  }

  Widget _buildBody(CalendarPageState state) {
    Widget body = Container();

    if (state is CalendarPageInitState || state is EventsLoading) {
      body = Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is EventsLoaded) {
      List<Event?>? events = state.events;
      body = _buildCalendar(events);
    }
    return body;
  }
}
