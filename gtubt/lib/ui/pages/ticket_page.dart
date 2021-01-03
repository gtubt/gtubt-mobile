import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/ui/pages/ticket_popup.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

class TicketPage extends StatelessWidget {

  final Ticket ticket1 = Ticket(
      title: "GeekDay 2020",
      name: "name1",
      location: "location1",
      date: "03-03-2020",
      hour: "hour1",
      codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg");
  final Ticket ticket2 = Ticket(
      title: "GeekDay 2021",
      name: "name2",
      location: "location2",
      date: "04-03-2021",
      hour: "hour2",
      codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg");
  final Ticket ticket3 = Ticket(
      title: "GeekDay 2022",
      name: "name3",
      location: "location3",
      date: "05-03-2022",
      hour: "hour3",
      codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg");
  final Ticket ticket4 = Ticket(
      title: "GeekDay 2023",
      name: "name4",
      location: "location4",
      date: "06-03-2023",
      hour: "hour4",
      codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg");
  final Ticket ticket5 = Ticket(
      title: "GeekDay 2024",
      name: "name5",
      location: "location5",
      date: "07-03-2024",
      hour: "hour5",
      codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg");
  final Ticket ticket6 = Ticket(
      title: "GeekDay 2025",
      name: "name6",
      location: "location6",
      date: "08-03-2025",
      hour: "hour6",
      codeUrl: "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg");

  @override
  Widget build(BuildContext context) {
    List<Ticket> pageTickets = [
      ticket1,
      ticket2,
      ticket3,
      ticket4,
      ticket5,
      ticket6
    ];
    return ListView.builder(
      itemCount: pageTickets.length,
      itemBuilder: (BuildContext context, int index) {
        var cardPadding = index == 0
            ? EdgeInsets.only(left: 22.0, right: 22.0, bottom: 22.0, top: 22.0)
            : EdgeInsets.only(left: 22.0, right: 22.0, bottom: 22.0);

        String day = "03";
        String month = "March";
        String year = "2020";

        return Padding(
          padding: cardPadding,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () => TicketPopup.showTicket(context, pageTickets[index]),
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
                            style: TextStyles.headline5.copyWith(color: ColorSets.lightTextColor),
                            children: <TextSpan>[
                              TextSpan(
                                text: day,
                                style: TextStyles.headline4.copyWith(color: ColorSets.lightTextColor),
                              ),
                              TextSpan(
                                text: "\n" + month,
                              ),
                              TextSpan(
                                text: "\n" + year,
                              ),
                            ])),
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
                      pageTickets[index].title,
                      style: TextStyles.headline4.copyWith(color: ColorSets.lightTextColor),
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
            }));
  }
}