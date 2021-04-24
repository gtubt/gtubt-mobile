import 'package:GTUBT/ui/blocs/ticket_bloc/bloc.dart';
import 'package:GTUBT/ui/pages/calendar_page.dart';
import 'package:GTUBT/ui/pages/home_page/page.dart';
import 'package:GTUBT/ui/pages/login_page.dart';
import 'package:GTUBT/ui/pages/main_page.dart';
import 'package:GTUBT/ui/pages/profile_page.dart';
import 'package:GTUBT/ui/pages/settings_page.dart';
import 'package:GTUBT/ui/pages/signup_page.dart';
import 'package:GTUBT/ui/pages/news_page.dart';
import 'package:GTUBT/ui/pages/splash_page.dart';
import 'package:GTUBT/ui/pages/ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const MAIN_URL = '/main';
const ROOT_URL = '/';
const LOGIN_URL = '/login';
const POST_URL = '/post';
const SIGN_UP_URL = '/sign_up';
const TICKET_URL = '/ticket';
const SETTINGS_URL = '/settings';
const CALENDER_URL = '/calender';

class Routes {
  static final routes = <String, WidgetBuilder>{
    ROOT_URL: (context) => SplashPage(),
    MAIN_URL: (context) => MainPage(),
    LOGIN_URL: (context) => LoginPage(),
    POST_URL: (context) => NewsPage(),
    SIGN_UP_URL: (context) => SignUpPage(),
    TICKET_URL: (context) => BlocProvider(
          create: (context) => TicketPageBloc(),
          child: TicketPage(),
        ),
    SETTINGS_URL: (context) => SettingsPage(),
    CALENDER_URL: (context) => CalendarPage(),
  };
  static const HOME = "Home";
  static const CALENDAR = "Calendar";
  static const PROFILE = "Profile";
  static const LOGIN = "Login";
  static final bodyTitleLoggedIn = [HOME, CALENDAR, PROFILE];
  static final bodyTitle = [HOME, CALENDAR, LOGIN];
  static final bodyListLoggenIn = <Widget>[
    HomePage(),
    CalendarPage(),
    ProfilePage(),
  ];
  static final bodyList = <Widget>[
    HomePage(),
    CalendarPage(),
    LoginPage(),
  ];
  static final navListLoggedIn = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: bodyTitleLoggedIn[0],
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: bodyTitleLoggedIn[1],
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: bodyTitleLoggedIn[2],
    ),
  ];
  static final navList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: bodyTitle[0],
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: bodyTitle[1],
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.login),
      label: bodyTitle[2],
    ),
  ];
}
