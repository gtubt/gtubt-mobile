import 'package:GTUBT/ui/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/authentication_state.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/user_bloc/user_bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget body;
  PageState _selectedPage;

  void _onNavigation(int index) {
    BlocProvider.of<PageBloc>(context).add(
      NavBarPageChanged(
        page: index,
        context: context,
      ),
    );
  }

  void _toggleProfileEdit() {
    BlocProvider.of<PageBloc>(context).add(
      NavBarPageChanged(
        page: _selectedPage.currentPage,
        context: context,
      ),
    ); // We call this to force icon change.
    BlocProvider.of<UserBloc>(context).add(ToggleEditMode());
  }

  List<Widget> _buildHamburgerMenuItems() {
    List<Widget> _menuItems = List<Widget>();
    AuthenticationBloc _authBloc = BlocProvider.of<AuthenticationBloc>(context);

    if (_authBloc.state is AuthenticationAuthenticated) {
      Widget profilePhoto = Container(
        child: Text('ProfilePhoto'),
      );
      Widget userName = Container(child: Text('Username'));
      Widget ticketButton = InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 50,
          color: ColorSets.profilePageThemeColor,
          child: Center(
            child: Text('TICKETS'),
          ),
        ),
        onTap: () => null,
      );
      _menuItems.add(profilePhoto);
      _menuItems.add(userName);
      _menuItems.add(ticketButton);
    } else {
      Widget loginButton = InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          height: 50,
          color: ColorSets.profilePageThemeColor,
          child: const Center(child: Text('LOGIN')),
        ),
        onTap: () {
          BlocProvider.of<PageBloc>(context).add(
            PageChanged(
              context: context,
              routeName: LOGIN_URL,
            ),
          );
        },
      );
      _menuItems.add(loginButton);
    }
    Widget settingsButton = Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      height: 50,
      color: ColorSets.profilePageThemeColor,
      child: const Center(child: Text('SETTINGS')),
    );

    _menuItems.add(settingsButton);
    return _menuItems;
  }

  @override
  Widget build(BuildContext context) {
    var actions = <Widget>[];

    return BlocListener<PageBloc, PageState>(
      listener: (BuildContext context, PageState state) {
        _selectedPage = state;
        if (Routes.bodyTitle[state.currentPage].toLowerCase() == "profile") {
          actions = <Widget>[];
          if (BlocProvider.of<UserBloc>(context).currentState.editMode) {
            actions.add(IconButton(
                icon: Icon(Icons.check), onPressed: _toggleProfileEdit));
          } else {
            actions.add(IconButton(
                icon: Icon(Icons.edit), onPressed: _toggleProfileEdit));
          }
        }
      },
      child: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorSets.barBackgroundColor,
              title: Text(Routes.bodyTitle[state.currentPage]),
              actions: actions,
            ),
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: ColorSets.unselectedBarItemColor,
              selectedIconTheme: IconThemeData(
                color: ColorSets.selectedBarItemColor,
              ),
              unselectedIconTheme: IconThemeData(
                color: ColorSets.unselectedBarItemColor,
              ),
              currentIndex: state.currentPage,
              backgroundColor: ColorSets.barBackgroundColor,
              onTap: _onNavigation,
              items: Routes.navList,
            ),
            drawer: Drawer(
              child: Container(
                color: ColorSets.barBackgroundColor,
                alignment: Alignment.center,
                child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: _buildHamburgerMenuItems()),
              ),
            ),
            body: Routes.bodyList[state.currentPage],
            // This trailing comma makes auto-formatting nicer for build methods.
          );
        },
      ),
    );
  }
}
