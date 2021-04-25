import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormBoxContainer{
  static InputDecoration textFieldStyle({String labelTextStr=""}) {
    return InputDecoration(
      labelText: labelTextStr,
      labelStyle: TextStyles.subtitle1.copyWith(color: ColorSets.profilePageThemeColor),
      contentPadding: EdgeInsets.only(left: 20),
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
          color: ColorSets.selectedInputFieldColor,
          width: 4.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
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
