import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormBoxContainer {
  static InputDecoration textFieldStyle({String labelTextStr = ""}) {
    return InputDecoration(
      labelText: labelTextStr,
      labelStyle: TextStyles.subtitle1.copyWith(
        color: ColorSets.lightTextColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.lightTextColor,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.lightTextColor,
          width: 1.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorSets.lightTextColor,
          width: 1.5,
        ),
      ),
    );
  }
}
