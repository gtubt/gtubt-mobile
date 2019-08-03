import 'package:flutter/material.dart';
import 'package:sample/ui/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTU BT',
      theme: ThemeData(
        // These will be customized for general app design
        primarySwatch: Colors.blue,
      ),
      routes: Routes.routes,
      initialRoute: '/',
    );
  }
}
