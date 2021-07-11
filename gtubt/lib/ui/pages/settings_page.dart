import 'package:flutter/material.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:GTUBT/ui/style/button_styles.dart';
import 'package:GTUBT/service/authentication.dart';
import 'package:GTUBT/ui/utils/notification.dart';
import 'package:another_flushbar/flushbar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _user = AuthService();
  Flushbar _notification = NotificationFactory.informationFactory(message: '');
  final GlobalKey<FormState> _passwordFieldKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  void _cardFunction(String _settingPageItemRouter) {
    context.read<PageBloc>().add(
          PageChanged(
            context: context,
            routeName: _settingPageItemRouter,
          ),
        );
  }

  Widget _buildSettingsPageItem({
    @required String? title,
    @required IconData? icon,
    @required dynamic route,
  }) {
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
                  title!,
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
              'To delete your account please enter your password.',
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
                    child: Text('Cancel'),
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
                      'Delete Account',
                      style: TextStyle(
                        color: Colors.white,
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

  Widget emailVerificationListing() {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              _passwordController.clear();
              return emailVerificationDialog();
            });
      },
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
                  child: Icon(
                    Icons.email,
                  ),
                ),
                Text(
                  'Email Verification',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Widget emailVerificationDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: ColorSets.popUpBackgroundColor,
      elevation: 40,
      child: Container(
        height: 180,
        padding: const EdgeInsets.only(
          top: 25.0,
          left: 25.0,
          right: 25.0,
        ),
        child: Column(
          children: [
            Text(
              'Please verify your email to keep using this application securely.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      try {
                        Navigator.pop(context);
                        _user.validateUserWithEmail();
                        _notification = NotificationFactory.successFactory(
                            title: 'Success',
                            message: 'Verifications email sent.');

                        _notification.show(context);
                      } catch (e) {
                        _notification = NotificationFactory.errorFactory(
                            title: 'Error',
                            message:
                                'Unable to send verification email. Error: $e');
                        _notification.show(context);
                      }
                    },
                    style: ButtonStyles.containedButton,
                    child: Text('Send verification email'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget accountDeleteListing() {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              _passwordController.clear();
              return accountDeletionDialog(context);
            });
      },
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
                  child: Icon(
                    Icons.delete_forever,
                  ),
                ),
                Text(
                  'Delete My Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Widget _buildSettingsPage() {
    List<Widget> _settingsPageItems = [
      _buildSettingsPageItem(
        title: 'Notification Preferences',
        icon: Icons.notifications,
        route: NOTIFICATION_PREFERENCES_URL,
      ),
      _buildSettingsPageItem(
        title: 'User Agreement (EULA)',
        icon: Icons.gavel,
        route: USER_AGREEMENT_URL,
      ),
      _buildSettingsPageItem(
        title: 'PDPL (KVKK) Information',
        icon: Icons.description,
        route: PDPL_INFO_URL,
      ),
      accountDeleteListing(),
    ];

    if (context.read<AuthenticationBloc>().state
        is AuthenticationAuthenticated) {
      _settingsPageItems.insert(
        1,
        _buildSettingsPageItem(
          title: 'Contact Preferences',
          icon: Icons.perm_phone_msg,
          route: CONTACT_PREFERENCES_URL,
        ),
      );
    }

    if (!_user.isVerified()) {
      _settingsPageItems.insert(
        4,
        emailVerificationListing(),
      );
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
                        'assets/logo.png',
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
