import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormBoxContainer{
  static InputDecoration textFieldStyle({String labelTextStr=""}) {
    return InputDecoration(
      labelText: labelTextStr,
      labelStyle: TextStyle(
        color: ColorSets.profilePageThemeColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

}
