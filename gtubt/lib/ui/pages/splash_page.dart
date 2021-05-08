import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Future _initialize() {
    // will be replaced with initialization code
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    _initialize().then((value) {
      Navigator.of(context).pushReplacementNamed(MAIN_URL);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorSets.appMainColor,
      alignment: Alignment.center,
      child: Row(
        children: [
          Spacer(flex: 8,),
          Expanded(flex: 20, child: Image.asset("assets/logo.png")),
          Spacer(flex: 8,),
        ],
      ),
    );
  }
}
