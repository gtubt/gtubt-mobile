import 'package:flutter/material.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

class ButtonStyles {
  static ButtonStyle containedButton = ElevatedButton.styleFrom(
    primary: ColorSets.outlinedButtonBackgroundColor,
    onPrimary: ColorSets.lightTextColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  static ButtonStyle outlinedButton = ElevatedButton.styleFrom(
      primary: ColorSets.outlinedButtonBackgroundBarColor,
      onPrimary: ColorSets.lightTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      side: BorderSide(color: Colors.white, width: 1.0));

  static ButtonStyle textButton =
      TextButton.styleFrom(primary: ColorSets.lightTextColor);
}
