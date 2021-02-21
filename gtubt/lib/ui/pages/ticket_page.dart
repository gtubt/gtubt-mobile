import 'package:GTUBT/ui/blocs/ticket_bloc/bloc.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/ui/pages/ticket_popup.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
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
    BlocProvider.of<TicketPageBloc>(context).add(FetchTickets());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketPageBloc, TicketPageState>(
      listener: (context, state) {},
      child: BlocBuilder<TicketPageBloc, TicketPageState>(
        builder: (context, TicketPageState state) {
          return Scaffold(
              backgroundColor: ColorSets.pageBackgroundColor,
              appBar: AppBar(
                title: Text("Tickets"),
                centerTitle: true,
                backgroundColor: ColorSets.barBackgroundColor,
                elevation: 0.0,
              ),
              body: _buildBody(state));
        },
      ),
    );
  }

  Widget _buildBody(TicketPageState state) {
    Widget body;

    if (state is TicketPageInitState || state is TicketsLoading) {
      body = Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is TicketsLoaded) {
      List<Ticket> tickets = state.tickets;
      body = ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (BuildContext context, int index) {
          var ticket = tickets[index];
          var cardPadding = index == 0
              ? EdgeInsets.only(
                  left: 22.0, right: 22.0, bottom: 22.0, top: 22.0)
              : EdgeInsets.only(left: 22.0, right: 22.0, bottom: 22.0);

          return Padding(
            padding: cardPadding,
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () => TicketPopup.showTicket(
                context,
                ticket,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: ColorSets.profilePageThemeColor,
                elevation: 5.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(19.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyles.headline5
                              .copyWith(color: ColorSets.lightTextColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: ticket.date.day.toString(),
                              style: TextStyles.headline4
                                  .copyWith(color: ColorSets.lightTextColor),
                            ),
                            TextSpan(
                              text: "\n" + months[ticket.date.month - 1],
                            ),
                            TextSpan(
                              text: "\n" + ticket.date.year.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DashedLine(
                      dashCount: 4,
                      dashHeight: 15,
                      dashWidth: 5,
                      color: ColorSets.lightTextColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(19.0),
                      child: Text(
                        ticket.title,
                        style: TextStyles.headline4
                            .copyWith(color: ColorSets.lightTextColor),
                      ),
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

class DashedLine extends StatelessWidget {
  final int dashCount;
  final double dashHeight;
  final double dashWidth;
  final Color color;

  DashedLine({this.dashCount, this.dashHeight, this.dashWidth, this.color});

  @override
  Widget build(BuildContext context) {
    double spacerHeight = dashHeight / 1.5;
    int spacerCount = dashCount - 1;
    double lineHeight = (dashCount * dashHeight) + (spacerCount * spacerHeight);
    return SizedBox(
      width: dashWidth,
      height: lineHeight,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: dashCount,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: color,
                      height: dashHeight,
                      width: dashWidth,
                    )),
                index != dashCount
                    ? Container(height: spacerHeight)
                    : Container(),
                // For don't adding space to end of the line
              ],
            );
          }),
    );
  }
}
