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
                  children: <Widget>[
                    InkWell(
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
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      height: 50,
                      color: ColorSets.profilePageThemeColor,
                      child: const Center(child: Text('SETTINGS')),
                    ),
                  ],
                ),
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
