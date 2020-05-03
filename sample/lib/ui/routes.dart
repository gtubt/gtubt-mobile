import 'package:GTUBT/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'pages/home_page.dart';
import 'pages/calendar_page.dart';
import 'pages/profile_page.dart';


const ROOT_URL = '/';
const LOGIN_URL = '/login';

class Routes {
  static final routes = <String, WidgetBuilder>{
    ROOT_URL: (context) => MainPage(),
    LOGIN_URL: (context) => LoginPage(),
  };

  static final bodyTitle = ["Home", "Calendar", "Profile"];
  static final bodyList = <Widget>[
    HomePage(),
    CalendarPage(),
    ProfilePage(),
  ];
  static final navList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(bodyTitle[0]),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text(bodyTitle[1]),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      title: Text(bodyTitle[2]),
    ),
  ];
}
