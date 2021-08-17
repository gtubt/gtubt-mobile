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
    isValidPhoneNumber = user!.phone != null
        ? Validators.isValidPhoneNumber(user!.phone!)
        : false;
    //TODO: Get preferences from the DB
    _settings = {
      'email': false,
      'sms': false,
    };
  }

  Widget _buildContactPreferenceCard({
    @required String? title,
    @required String? description,
    @required String? type,
  }) {
    String? sms = 'sms';
    bool isSms = type == sms;

    String? cardText() {
      return isSms
          ? isValidPhoneNumber!
              ? description
              : 'This option requires a\nvalid phone number!'
          : description;
    }

    Color? cardColor() {
      return isSms
          ? isValidPhoneNumber!
              ? Colors.black54
              : Colors.red
          : Colors.black54;
    }

    bool cardEnabled() {
      return isSms
                ? isValidPhoneNumber!
                    ? true
                    : false
                : true;
    }

    void onChanged(bool value) {
      if (isSms && isValidPhoneNumber!) {
        setState(() {
          _settings[type!] = value;
        });
      } else if (isSms && !isValidPhoneNumber!) {
        null;
      } else {
        setState(() {
          _settings[type!] == value;
        });
      }
    }

    return Card(
      elevation: 10,
      child: Container(
        height: 75,
        child: MergeSemantics(
          child: ListTile(
            enabled: cardEnabled(),
            contentPadding: EdgeInsets.only(top: 5, left: 15, right: 10),
            title: Text(title!),
            subtitle: Text(
              cardText()!,
              style: TextStyle(
                color: cardColor(),
              ),
            ),
            trailing: Switch(
              activeColor: ColorSets.cursorColor,
              value: _settings[type]!,
              onChanged: (value) => {
                onChanged(value),
              },
            ),
            onTap: () {
              setState(() {
                _settings[type!] = !_settings[type]!;
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
        title: 'Email',
        description: 'Choose whether or not\nto get information emails',
        type: 'email',
      ),
      _buildContactPreferenceCard(
        title: 'SMS',
        description: 'Choose wether or not to\nget information messages',
        type: 'sms',
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
