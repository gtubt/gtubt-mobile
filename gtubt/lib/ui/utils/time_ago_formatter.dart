import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class TimeAgoFormatter {
  final inputDate;

  TimeAgoFormatter(this.inputDate);

  @override
  String toString() {
    final date = inputDate.toString();
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedString = formatter.parse(date);
    final now = DateTime.now();
    final difference = now.difference(formattedString);
    final dateTime = DateTime.now().subtract(difference);
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    return timeago.format(dateTime, locale: "tr");
  }
}
