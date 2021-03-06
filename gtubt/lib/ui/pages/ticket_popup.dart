import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/models/ticket.dart';
import 'package:intl/intl.dart';

// Usage: TicketPopup.showTicket(context, ticket);
class TicketPopup {
  static void showTicket(context, Ticket ticket) {
    String? title = ticket.title;
    String? name = ticket.name;
    String? location = ticket.location;
    String date = DateFormat('yMd').format(ticket.date!);
    String time = DateFormat('Hm').format(ticket.date!);
    String? codeUrl = ticket.codeUrl;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: ColorSets.appMainColor, width: 2),
            ),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Event:",
                          style: TextStyles.headline5
                              .copyWith(color: ColorSets.appMainColor),
                        ),
                        Text(title!,
                            style: TextStyles.headline6.copyWith(
                                color: ColorSets.ticketInformationTextColor)),
                        Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                LabeledText(
                                  label: "Attandee: ",
                                  text: name,
                                ),
                                LabeledText(
                                  label: "Location: ",
                                  text: location,
                                ),
                                LabeledText(
                                  label: "Date: ",
                                  text: date,
                                ),
                                LabeledText(
                                  label: "Time: ",
                                  text: time,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 16,
                                    bottom: 10,
                                  ),
                                  child: DashSeparator(
                                    color: ColorSets.appMainColor,
                                  ),
                                ),
                                Image.network(
                                  codeUrl!,
                                  height: 130,
                                  width: 130,
                                  errorBuilder: (
                                    BuildContext context,
                                    Object exception,
                                    StackTrace? stacktrace,
                                  ) {
                                    return Image.asset(
                                      "assets/qr.png",
                                      height: 130,
                                      width: 130,
                                    );
                                  },
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class LabeledText extends StatelessWidget {
  final String? label;
  final String? text;

  LabeledText({this.label, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              label!,
              textAlign: TextAlign.right,
              style: TextStyles.subtitle1.copyWith(
                color: ColorSets.appMainColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text!,
              style: TextStyles.subtitle1.copyWith(
                color: ColorSets.ticketInformationTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DashSeparator extends StatelessWidget {
  final double height;
  final Color color;

  const DashSeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
