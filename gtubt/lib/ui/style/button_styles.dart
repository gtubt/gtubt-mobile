import 'package:flutter/material.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

class ButtonStyles {
  static ButtonStyle loginButton = ElevatedButton.styleFrom(
      primary: ColorSets.loginButtonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));
  static ButtonStyle loginPageButton = ElevatedButton.styleFrom(
      primary: ColorSets.barBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));
  static ButtonStyle forgotPasswordButton =
      TextButton.styleFrom(primary: ColorSets.barBackgroundColor);
  static ButtonStyle deleteAccountButton = ElevatedButton.styleFrom(
      primary: ColorSets.profilePageThemeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: ColorSets.lightTextColor),
      ),
      textStyle: TextStyle(
        color: ColorSets.lightTextColor,
      ));
  static ButtonStyle cancelButton = ElevatedButton.styleFrom(
      primary: ColorSets.barBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      textStyle: TextStyle(
        color: ColorSets.lightTextColor,
      ));
  static ButtonStyle createAccountButton = ElevatedButton.styleFrom(
      primary: ColorSets.selectedBarItemColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));
}

class ButtonDecorations {
  static BoxDecoration loginPageButton = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: ColorSets.barBackgroundColor,
    border: Border.all(
      color: Colors.white,
      width: 1.0,
    ),
  );
}
