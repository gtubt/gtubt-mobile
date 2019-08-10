import 'package:GTUBT/ui/pages/image_page.dart';
import 'package:flutter/material.dart';
import 'pages/list_page.dart';
import 'pages/main_page.dart';

const ROOT_URL = '/';

class Routes {
  static final routes = <String, WidgetBuilder>{
    ROOT_URL: (context) => ExamplePage(),
  };
  
  static final bodyTitle = ["Home", "List"];
  static final bodyList = <Widget>[
    ListPage(),
    ImagePage(),
  ];
  static final navList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(bodyTitle[0]),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.ac_unit),
      title: Text(bodyTitle[1]),
    ),
  ];
}