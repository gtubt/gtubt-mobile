import 'package:GTUBT/ui/components/base_app_bar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('Setting'),
      ),
      body: Center(
        child: TextButton(
          child: Text('More Info'),
          onPressed: () => showAboutDialog(context: context),
        ),
      ),
    );
  }
}
