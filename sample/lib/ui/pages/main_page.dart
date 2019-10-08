import 'package:GTUBT/resources/colors.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
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
            backgroundColor: GtuBtColors.barBackgroundColor,
            title: Text(Routes.bodyTitle[_selectedIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: GtuBtColors.unselectedBarItemColor,
            selectedIconTheme: IconThemeData(
              color: GtuBtColors.selectedBarItemColor,
            ),
            unselectedIconTheme: IconThemeData(
              color: GtuBtColors.unselectedBarItemColor,
            ),
            currentIndex: _selectedIndex,
            backgroundColor: GtuBtColors.barBackgroundColor,
            onTap: _onNavigation,
            items: Routes.navList,
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text("Ttem 1"),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: Text("Item 2"),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
          body: Routes.bodyList[_selectedIndex],
        // This trailing comma makes auto-formatting nicer for build methods.
        ),
      );
  }
}