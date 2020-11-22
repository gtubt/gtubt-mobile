import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';

// We need ticket model for here.
// Usage: TicketPopup.showTicket(context, ticket);
class TicketPopup {
  static void showTicket(context, ticket){
    String title = "Event Title";
    String name = "Full Name";
    String location = "Place";
    String date = "01.01.2020";
    String hour = "10:00";
    String codeUrl = "";
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)), side: BorderSide(color: Color.fromRGBO(0, 0, 255, 1), width: 2)),
          child: Padding(
            padding: new EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Event", style: new TextStyle(color: ColorSets.barBackgroundColor, fontWeight: FontWeight.bold),),
                Text(title, style: new TextStyle(color: ColorSets.profilePageThemeColor)),
                Padding(
                  padding: new EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Attandee: ", style: new TextStyle(color: ColorSets.barBackgroundColor, fontWeight: FontWeight.bold),),
                          Text(name, style: new TextStyle(color: ColorSets.profilePageThemeColor)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Location: ", style: new TextStyle(color: ColorSets.barBackgroundColor, fontWeight: FontWeight.bold), ),
                          Text(location, style: new TextStyle(color: ColorSets.profilePageThemeColor)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Date: ", style: new TextStyle(color: ColorSets.barBackgroundColor, fontWeight: FontWeight.bold),),
                          Text(date, style: new TextStyle(color: ColorSets.profilePageThemeColor)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Time: ", style: new TextStyle(color: ColorSets.barBackgroundColor, fontWeight: FontWeight.bold),),
                          Text(hour, style: new TextStyle(color: ColorSets.profilePageThemeColor)),
                        ],
                      ),
                      Padding(
                        padding: new EdgeInsets.only(top: 10, bottom: 10,),
                        child: DashSeperator(color: ColorSets.barBackgroundColor,),
                      ),
                      Image.network(codeUrl)
                    ],)
                )
              ],
            ),
          ),
        );
      } 
    );
  }
}

class DashSeperator extends StatelessWidget {
  final double height;
  final Color color;

  const DashSeperator({this.height = 1, this.color = Colors.black});

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