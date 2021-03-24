import 'package:GTUBT/exceptions/base.dart';

class EventException extends BaseException {
  final String message;
  
  EventException([String message])
      : message = message == null ? defaultMessage : message,
        super();

  factory EventException.message(String message) {
    return EventException(message);
  }

  static String get defaultMessage => "Something went wrong!";
}