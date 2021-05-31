import 'package:GTUBT/exceptions/base.dart';
import 'package:GTUBT/exceptions/enums.dart';

class AuthenticationException extends BaseException {
  final String message;
  
  AuthenticationException([String? message])
      : message = message == null ? defaultMessage : message,
        super();

  factory AuthenticationException.message(String message) {
    return AuthenticationException(message);
  }

  factory AuthenticationException.errorCode(String errorCode) {
    String? message;
    AuthenticationExceptionEnum.values.forEach((element) {
      if (element.getString() == errorCode) {
        message = element.getMessage();
      }
    });

    if (message != null) return AuthenticationException(message);
    return AuthenticationException(defaultMessage);
  }

  static String get defaultMessage => "Something went wrong!";
}
