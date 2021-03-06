import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

class FormBoxContainer {
  static InputDecoration textFieldStyle({String labelTextStr = ""}) {
    return InputDecoration(
      labelText: labelTextStr,
      labelStyle:
          TextStyles.subtitle1.copyWith(color: ColorSets.profilePageThemeColor),
      contentPadding: EdgeInsets.only(left: 20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.profilePageThemeColor,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.profilePageThemeColor,
          width: 3.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.profilePageThemeColor,
          width: 2.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.profilePageThemeColor,
          width: 2.0,
        ),
      ),
    );
  }

  static InputDecoration loginPageTextFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding:
        EdgeInsets.only(left: 12.0, right: 12.0, top: 2.0, bottom: 2.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
      borderSide: BorderSide.none,
    ),
  );
}

class FormInputDecoration extends InputDecoration {
  @override
  Color get fillColor => Colors.white;

  @override
  bool get filled => true;
}
