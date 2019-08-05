import 'package:flutter/material.dart';
import 'package:sample/ui/routes.dart';

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {  
  Widget body;
  int _selectedIndex = 0; 

  void _onNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Routes.bodyTitle[_selectedIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[900],
        onTap: _onNavigation,
        items: Routes.navList,
      ),
      body: Routes.bodyList[_selectedIndex],
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}