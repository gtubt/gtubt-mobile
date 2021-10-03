import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends AppBar {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final double? elevation;
  final PreferredSizeWidget? bottom;

  BaseAppBar(
      {this.title, this.actions, this.leading, this.elevation,this.bottom});

  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: ColorSets.lightTextColor),
      title: title,
      backgroundColor: ColorSets.appMainColor,
      actions: actions,
      centerTitle: true,
      leading: leading,
      elevation: elevation,
      bottom: bottom,
    );
  }
}
