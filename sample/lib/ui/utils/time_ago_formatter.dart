import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class TimeAgoFormatter {
  final date;

  TimeAgoFormatter(this.date);

  @override
  String toString() {
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedString = formatter.parse(date);
    final now = DateTime.now();
    final difference = now.difference(formattedString);
    final dateTime = DateTime.now().subtract(difference);
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    return timeago.format(dateTime, locale: "tr");
  }
}
