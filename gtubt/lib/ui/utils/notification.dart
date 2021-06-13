import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

EdgeInsets getFlushbarMargin() {
  return EdgeInsets.only(left: 8, right: 8, bottom: 8);
}

class NotificationFactory {
  static Flushbar successFactory({
    String? title,
    required String message,
  }) {
    return Flushbar(
      onTap: (flushbar) => {flushbar.dismiss()},
      title: title,      
      message: message,
      titleColor: ColorSets.successNotificationTextColor,
      messageColor: ColorSets.successNotificationTextColor,
      backgroundColor: ColorSets.successNotificationThemeColor,
      icon: Icon(Icons.check, color: ColorSets.successNotificationTextColor),
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
      borderRadius: BorderRadius.circular(16),
    );
  }

  static Flushbar errorFactory({
    String? title,
    required String? message,
  }) {
    return Flushbar(
      onTap: (flushbar) => {flushbar.dismiss()},
      title: title,
      message: message,
      titleColor: ColorSets.errorNotificationTextColor,
      messageColor: ColorSets.errorNotificationTextColor,
      backgroundColor: ColorSets.errorNotificationThemeColor,
      icon: Icon(Icons.error, color: ColorSets.errorNotificationTextColor),
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
      borderRadius: BorderRadius.circular(16),
    );
  }

  static Flushbar warningFactory({
    String? title,
    required String message,
  }) {
    return Flushbar(
      onTap: (flushbar) => {flushbar.dismiss()},
      title: title,
      message: message,
      titleColor: ColorSets.warningNotificationTextColor,
      messageColor: ColorSets.warningNotificationTextColor,
      backgroundColor: ColorSets.warningNotificationThemeColor,
      icon: Icon(Icons.warning, color: ColorSets.warningNotificationTextColor),
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
      borderRadius: BorderRadius.circular(16),
    );
  }

  static Flushbar loadingFactory({
    String? title,
    required String? message,
  }) {
    return Flushbar(
      title: title,
      message: message,
      backgroundColor: ColorSets.infoNotificationThemeColor,
      // showProgressIndicator: true, // This does not work very well with rounded corners.
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
      borderRadius: BorderRadius.circular(16),
      /*TODO: Loading requires more attention. We should use either
        Circular or Linear progess bar instead of a flushbar. */
    );
  }

  static Flushbar informationFactory({
    String? title,
    required String message,
  }) {
    return Flushbar(
      onTap: (flushbar) => {flushbar.dismiss()},
      title: title,
      message: message,
      titleColor: ColorSets.infoNotificationTextColor,
      messageColor: ColorSets.infoNotificationTextColor,
      backgroundColor: ColorSets.infoNotificationThemeColor,
      icon: Icon(Icons.info, color: ColorSets.infoNotificationTextColor),
      duration: Duration(seconds: 5),
      margin: getFlushbarMargin(),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
