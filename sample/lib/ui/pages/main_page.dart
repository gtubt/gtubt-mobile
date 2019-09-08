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
            title: Text(Routes.bodyTitle[_selectedIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            backgroundColor: Colors.indigo[900],
            selectedItemColor: Colors.grey,
            onTap: _onNavigation,
            items: Routes.navList,
          ),
          body: Routes.bodyList[_selectedIndex],
        // This trailing comma makes auto-formatting nicer for build methods.
        ),
      );
  }
}