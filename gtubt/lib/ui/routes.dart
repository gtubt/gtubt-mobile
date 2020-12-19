import 'package:GTUBT/ui/pages/calendar_page.dart';
import 'package:GTUBT/ui/pages/home_page/page.dart';
import 'package:GTUBT/ui/pages/login_page.dart';
import 'package:GTUBT/ui/pages/main_page.dart';
import 'package:GTUBT/ui/pages/profile_page.dart';
import 'package:GTUBT/ui/pages/signup_page.dart';
import 'package:GTUBT/ui/pages/post_page.dart';
import 'package:flutter/material.dart';

const ROOT_URL = '/';
const LOGIN_URL = '/login';
const POST_URL = '/post';
const SIGN_UP_URL = '/sign_up';

class Routes {
  static final routes = <String, WidgetBuilder>{
    ROOT_URL: (context) => MainPage(),
    LOGIN_URL: (context) => LoginPage(),
    POST_URL: (context) => PostPage(),
    SIGN_UP_URL: (context) => SignUpPage(),
  };

  static final bodyTitle = ["Home", "Calendar", "Profile"];
  static final bodyList = <Widget>[
    HomePage(),
    CalendarPage(),
    ProfilePage(),
  ];
  static final navListLoggedIn = <BottomNavigationBarItem>[
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
  static final navList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(bodyTitle[0]),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text(bodyTitle[1]),
    ),
  ];
}
