import 'package:flutter/material.dart';

const double _height = 6.0;

class AppBarLinearProgressIndicator extends SizedBox
    implements PreferredSizeWidget {
  final bool isLoading;
  AppBarLinearProgressIndicator(this.isLoading)
      : super(child: isLoading ? LinearProgressIndicator() : Container());

  @override
  final Size preferredSize = Size(double.infinity, _height);
}
