import 'package:flutter/material.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:GTUBT/ui/style/button_styles.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _passwordFieldKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  void _cardFunction(String route) {
    context.read<PageBloc>().add(
          PageChanged(
            context: context,
            routeName: route,
          ),
        );
  }

  Widget _buildSettingsPageItem(
      BuildContext context, String title, IconData icon, dynamic route) {
    return InkWell(
      onTap: () => _cardFunction(route),
      child: Card(
        elevation: 10,
        child: Container(
          height: 75,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Icon(icon),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Widget accountDeletionDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: ColorSets.popUpBackgroundColor,
      elevation: 40,
      child: Container(
        height: 300,
        // width: 650,
        padding: const EdgeInsets.only(
          top: 25.0,
          left: 25.0,
          right: 25.0,
        ),
        child: Column(
          children: [
            Text(
              "To delete your account please enter your password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            SizedBox(height: 15),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Form(
                    key: _passwordFieldKey,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        final authState =
                            context.read<AuthenticationBloc>().state;
                        if (authState is AuthenticationError) {
                          return authState.message;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyles.outlinedButton,
                    child: Text("Cancel"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_passwordFieldKey.currentState!.validate()) {
                        context.read<AuthenticationBloc>().add(
                              DeleteAcc(
                                password: _passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    style: ButtonStyles.containedButton,
                    child: Text(
                      "Delete Account",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'This will delete your account without any recovery chance!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsPage() {
    List<Widget> _settingsPageItems = [
      _buildSettingsPageItem(
        context,
        'Notification Preferences',
        Icons.notifications,
        NOTIFICATION_PREFERENCES_URL,
      ),
      _buildSettingsPageItem(
        context,
        'User Agreement (EULA)',
        Icons.gavel,
        USER_AGREEMENT_URL,
      ),
      _buildSettingsPageItem(
        context,
        'PDPL (KVKK) Information',
        Icons.description,
        PDPL_INFO_URL,
      ),
      InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                _passwordController.clear();
                return accountDeletionDialog(context);
              });
        },
        child: Card(
          color: Colors.redAccent,
          elevation: 10,
          child: Container(
            height: 75,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Delete Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )
                ]),
          ),
        ),
      ),
    ];

    if (context.read<AuthenticationBloc>().state
        is AuthenticationAuthenticated) {
      _settingsPageItems.insert(
          1,
          _buildSettingsPageItem(context, 'Contact Preferences',
              Icons.perm_phone_msg, CONTACT_PREFERENCES_URL));
    }

    return SingleChildScrollView(
      child: Column(
        // shrinkWrap: true,
        children: _settingsPageItems,
      ),
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
            'Settings',
            style: TextStyle(color: ColorSets.lightTextColor),
          ),
          iconTheme: IconThemeData(color: ColorSets.lightTextColor)),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {},
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                  return Container(
                    child: _buildSettingsPage(),
                  );
                })),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Center(
                child: TextButton(
                  child: Text(
                    'More Info',
                  ),
                  onPressed: () => showAboutDialog(
                    context: context,
                    applicationIcon: Container(
                      padding: EdgeInsets.only(top: 20),
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/logo_textless.png',
                        color: ColorSets.appMainColor,
                      ),
                    ),
                    applicationVersion: 'v1.0.0',
                    applicationName: 'GTU BT',
                    applicationLegalese:
                        '\u00a9 Computer Society of Gebze Technical University\nAll rights reserved\n2021',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
