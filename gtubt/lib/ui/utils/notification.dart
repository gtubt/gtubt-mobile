import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

EdgeInsets getFlushbarMargin() {
  return EdgeInsets.only(left: 8, right: 8, bottom: 8);
}

class NotificationFactory {
  static Flushbar successFactory({
    String title,
    @required String message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      icon: Icon(Icons.info),
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static Flushbar errorFactory({
    String title,
    @required String message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      icon: Icon(Icons.error),
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static Flushbar warningFactory({
    String title,
    @required String message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      icon: Icon(Icons.error),
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static Flushbar loadingFactory({
    String title,
    @required String message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      showProgressIndicator: true,
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
    );
  }

  static Flushbar informationFactory({
    String title,
    @required String message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      icon: Icon(Icons.info),
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
