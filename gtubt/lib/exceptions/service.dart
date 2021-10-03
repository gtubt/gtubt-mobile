import 'package:GTUBT/exceptions/base.dart';

class UnsupportedPlatformException extends BaseException {
  final String message;

  UnsupportedPlatformException([String? message])
      : message = message == null ? defaultMessage : message,
        super();

  factory UnsupportedPlatformException.message(String? message) {
    return UnsupportedPlatformException(message);
  }

  static String get defaultMessage => "Unsupported platform.";
}