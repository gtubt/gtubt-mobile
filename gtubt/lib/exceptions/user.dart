import 'package:GTUBT/exceptions/base.dart';

class UserException extends BaseException {
  final String message;
  
  UserException([String message])
      : message = message == null ? defaultMessage : message,
        super();

  factory UserException.message(String message) {
    return UserException(message);
  }

  static String get defaultMessage => "Something went wrong!";
}
