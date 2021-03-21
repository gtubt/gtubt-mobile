import 'package:GTUBT/exceptions/base.dart';
import 'package:GTUBT/exceptions/enums.dart';

class UserException extends BaseException {
  final String message;
  
  UserException([String message])
      : message = message == null ? defaultMessage : message,
        super();

  factory UserException.message(String message) {
    return UserException(message);
  }

  factory UserException.errorCode(String errorCode) {
    String message;
    AuthenticationExceptionEnum.values.forEach((element) {
      if (element.getString() == errorCode) {
        message = element.getMessage();
      }
    });

    if (message != null) return UserException(message);
    return UserException(defaultMessage);
  }

  static String get defaultMessage => "Something went wrong!";
}
