import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
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
    BlocProvider.of<PageBloc>(context).dispatch(PageChanged(page: index));
  }

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, ),
                    height: 50,
                    color: ColorSets.profilePageThemeColor,
                    child: const Center(child: Text('LOGIN')),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, ),
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