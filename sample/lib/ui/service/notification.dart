import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Flushbar successFactory({
    String title,
    @required String message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: 5),
      icon: Icon(Icons.info),
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
      ),
      borderRadius: 8,
    );
  }

  static Flushbar errorFactory({
    String title,
    @required String message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: 5),
      backgroundColor: ColorSets.snackBarErrorColor,
      icon: Icon(Icons.error),
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
      ),
      borderRadius: 8,
    );
  }

  static Flushbar warningFactory({
    String title,
    @required String message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: 5),
      icon: Icon(Icons.warning),
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
      ),
      borderRadius: 8,
    );
  }

  static Flushbar loadingFactory({
    String title,
    @required String message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: 10),
      showProgressIndicator: true,
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
      ),
    );
  }
}
