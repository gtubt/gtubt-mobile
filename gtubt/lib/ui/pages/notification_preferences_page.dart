import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

class NotificationPreferencesPage extends StatefulWidget {
  @override
  _NotificatioPreferencesPageState createState() =>
      _NotificatioPreferencesPageState();
}

class _NotificatioPreferencesPageState
    extends State<NotificationPreferencesPage> {
  Map<String, bool> _settings = {};

  @override
  initState() {
    super.initState();
    //TODO: Get preferences from the DB
    _settings = {
      'event': false,
      'announcement': false,
      'reminder': false,
    };
  }

  Widget _buildPreferenceItem(
      BuildContext context, String title, String description, type) {
    return Card(
      elevation: 10,
      child: Container(
        height: 75,
        child: MergeSemantics(
          child: ListTile(
            contentPadding: EdgeInsets.only(top: 5, left: 15, right: 10),
            title: Text(title),
            subtitle: Text(description),
            trailing: CupertinoSwitch(
              activeColor: ColorSets.cursorColor,
              value: _settings[type]!,
              onChanged: (bool value) {
                setState(() {
                  _settings[type] = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                _settings[type] = !_settings[type]!;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsPage() {
    List<Widget> _settingsPageItems = [
      _buildPreferenceItem(
        context,
        'Event Notifications',
        'Notifies you for the events\nthat you have registered',
        'event',
      ),
      _buildPreferenceItem(
        context,
        'Announcements',
        'Notifies you for the announcements\nby Computer Society',
        'announcement',
      ),
      _buildPreferenceItem(
        context,
        'Reminders',
        'Notifies you about registiration\nand event dates',
        'reminder',
      ),
    ];

    return ListView(
      shrinkWrap: true,
      children: _settingsPageItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: ColorSets.appMainColor,
          centerTitle: true,
          title: Text(
            'Notification Preferences',
            style: TextStyle(color: ColorSets.lightTextColor),
          ),
          iconTheme: IconThemeData(color: ColorSets.lightTextColor)),
      body: Container(
        child: Column(
          children: [
            Container(
              child: _buildSettingsPage(),
            )
          ],
        ),
      ),
    );
  }
}
