import 'package:GTUBT/exceptions/base.dart';

class PostException extends BaseException {
  final String message;
  
  PostException([String message])
      : message = message == null ? defaultMessage : message,
        super();

  factory PostException.message(String message) {
    return PostException(message);
  }

  static String get defaultMessage => "Something went wrong!";
}