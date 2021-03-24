import 'package:GTUBT/exceptions/base.dart';

class TicketException extends BaseException {
  final String message;
  
  TicketException([String message])
      : message = message == null ? defaultMessage : message,
        super();

  factory TicketException.message(String message) {
    return TicketException(message);
  }

  static String get defaultMessage => "Something went wrong!";
}