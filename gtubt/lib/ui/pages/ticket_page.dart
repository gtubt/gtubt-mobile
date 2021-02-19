import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/models/ticket.dart';
import 'package:GTUBT/ui/pages/ticket_popup.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

class TicketPage extends StatelessWidget {
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
  Future<List<Ticket>> getAll() async {
    final String baseUrl =
        'https://us-central1-gtubtmobile-bb186.cloudfunctions.net';
    final String endpointPrefix = 'gtubt-api';
    final String servicePath = 'tickets'; //TODO : TİCKET ENDPOİNT YAZILMALI
    String url = '$baseUrl/$endpointPrefix/$servicePath';

//    final response = await http.get('$url');
//    print('response::::::::::::::::::::${response.body}');
//    print('statusCode::::::::::::::::::::${response.statusCode}');
//    try {
//      final extractedData = json.decode(response.body) as Map<String, dynamic>;
//      print('extractedData::::::::::::::::::::::::::::::::${extractedData}');
//      List<Ticket> temp = [];
//      extractedData.forEach(
//        (id, data) {
//          Ticket ticket = Ticket(
//            name: data['name'],
//            title: data['title'],
//            codeUrl: data['codeUrl'],
//            location: data['location'],
//            date: data['date'],
//          );
//          print('nameeeeeeeeeeeEEE:::::::::::::::::::::::::${ticket.name}');
//          temp.add(ticket);
//        },
//      );
//      pageTickets = temp;
//    } catch (error) {
//      print(error);
//    }
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
          codeUrl:
              "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg"),
      Ticket(
          title: "GeekDay 2022",
          name: "name3",
          location: "location3",
          date: DateTime(2020, 7, 13),
          codeUrl:
              "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg"),
      Ticket(
          title: "GeekDay 2023",
          name: "name4",
          location: "location4",
          date: DateTime(2020, 7, 13),
          codeUrl:
              "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg"),
      Ticket(
          title: "GeekDay 2024",
          name: "name5",
          location: "location5",
          date: DateTime(2020, 7, 13),
          codeUrl:
              "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg"),
      Ticket(
          title: "GeekDay 2025",
          name: "name6",
          location: "location6",
          date: DateTime(2020, 7, 13),
          codeUrl:
              "https://upload.wikimedia.org/wikipedia/tr/d/d3/QR_kodu.jpeg")
    ];
    return pageTickets;

//    if (response.statusCode == 200) {
//      final apiResponse =
//          ApiResponseList<Ticket>.fromJson(json.decode(response.body));
//      print('apiResponse::::::::::::::::::::${apiResponse.body}');
//      if (apiResponse.status == 200) {
//        return Left(apiResponse.body);
//      }
//    }
    //   return Right(PostFailure("Couldn't find the post 😱"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSets.pageBackgroundColor,
      appBar: AppBar(
        title: Text("Tickets"),
        centerTitle: true,
        backgroundColor: ColorSets.barBackgroundColor,
        elevation: 0.0,
      ),
      body: StreamBuilder<Object>(
        stream: getAll().asStream(),
        builder: (context, snapshot) {
          List<Ticket> tickets = snapshot.data;
          print('snapshot.data::::::::::::::::::${snapshot.data}');
          print(
              'snapshot.connectionState::::::::::::::::::${snapshot.connectionState}');
          print('snapshot.error::::::::::::::::::${snapshot.error}');
          print('snapshot.hasData::::::::::::::::::${snapshot.hasData}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Text(
                'Error',
              ),
            );
          } else {
            return ListView.builder(
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
                                    style: TextStyles.headline4.copyWith(
                                        color: ColorSets.lightTextColor),
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
        },
      ),
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
