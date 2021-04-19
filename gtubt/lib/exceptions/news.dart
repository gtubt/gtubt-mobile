import 'package:GTUBT/exceptions/base.dart';

class NewsException extends BaseException {
  final String message;
  
  NewsException([String message])
      : message = message == null ? defaultMessage : message,
        super();

  factory NewsException.message(String message) {
    return NewsException(message);
  }

  static String get defaultMessage => "Something went wrong!";
}