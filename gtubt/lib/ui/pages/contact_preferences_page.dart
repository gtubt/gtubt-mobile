import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GTUBT/ui/utils/validators.dart';

class ContactPreferencesPage extends StatefulWidget {
  @override
  _ContactPreferencesPageState createState() => _ContactPreferencesPageState();
}

class _ContactPreferencesPageState extends State<ContactPreferencesPage> {
  User? user;
  Map<String, bool> _settings = {};
  bool? isValidPhoneNumber;

  @override
  initState() {
    super.initState();
    user = context.read<UserBloc>().userService.currentUser!;
    isValidPhoneNumber = Validators.isValidPhoneNumber(user!.phone!);
    //TODO: Get preferences from the DB
    _settings = {
      'email': false,
      'sms': false,
    };
  }

  Widget _buildContactPreferenceCard(
      BuildContext context, String title, String description, type) {
    return Card(
      elevation: 10,
      child: Container(
        height: 75,
        child: MergeSemantics(
          child: ListTile(
            enabled: type == 'sms'
                ? isValidPhoneNumber!
                    ? true
                    : false
                : true,
            contentPadding: EdgeInsets.only(top: 5, left: 15, right: 10),
            title: Text(title),
            subtitle: Text(
              type == 'sms'
                  ? isValidPhoneNumber!
                      ? description
                      : 'This option requires a\nvalid phone number!'
                  : description,
              style: TextStyle(
                color: type == 'sms'
                    ? isValidPhoneNumber!
                        ? Colors.black54
                        : Colors.red
                    : Colors.black54,
              ),
            ),
            trailing: CupertinoSwitch(
                activeColor: ColorSets.cursorColor,
                value: _settings[type]!,
                onChanged: type == 'sms'
                    ? isValidPhoneNumber!
                        ? (bool value) {
                            setState(() {
                              _settings[type] = value;
                            });
                          }
                        : null
                    : (bool value) {
                        setState(() {
                          _settings[type] = value;
                        });
                      }),
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
      _buildContactPreferenceCard(
        context,
        'Email',
        'Choose whether or not\nto get information mails',
        'email',
      ),
      _buildContactPreferenceCard(
        context,
        'SMS',
        'Choose wether or not to\nget information messages',
        'sms',
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
            'Contact Preferences',
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
