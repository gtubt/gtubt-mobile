import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/widgets.dart';

class FormBoxContainer extends Container {
  final Widget child;

  @override
  EdgeInsetsGeometry get margin => EdgeInsets.all(10.0);

  @override
  // TODO: implement constraints
  BoxConstraints get constraints =>
      BoxConstraints.tightFor(width: 350, height: 80);

  @override
  Decoration get decoration => BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      );

  FormBoxContainer({this.child}) : super(child: child);
}
