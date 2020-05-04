import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/user_bloc/user_bloc.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../routes.dart';

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  Widget body;
  int _selectedIndex = 0;

  void _onNavigation(int index) {
    BlocProvider.of<PageBloc>(context).add(PageChanged(page: index));
  }

  void _toggleProfileEdit() {
    BlocProvider.of<PageBloc>(context).add(PageChanged(page: _selectedIndex)); // We call this to force icon change.
    BlocProvider.of<UserBloc>(context).add(ToggleEditMode());
  }

  @override
  Widget build(BuildContext context) {
    var actions = <Widget>[];
    if (Routes.bodyTitle[_selectedIndex].toLowerCase() == "profile") {
      if (BlocProvider.of<UserBloc>(context).currentState.editMode) {
        actions.add(
          IconButton(icon: Icon(Icons.check), onPressed: _toggleProfileEdit));
      } else {
        actions.add(
          IconButton(icon: Icon(Icons.edit), onPressed: _toggleProfileEdit));
      }
    }
    
    return BlocListener<PageBloc, PageState>(
      listener: (BuildContext context, PageState state) {
        setState(() {
          _selectedIndex = state.currentPage;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorSets.barBackgroundColor,
          title: Text(Routes.bodyTitle[_selectedIndex]),
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
          currentIndex: _selectedIndex,
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
                  onTap: () => Navigator.pushNamed(context, '/login'),
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
        body: Routes.bodyList[_selectedIndex],
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
