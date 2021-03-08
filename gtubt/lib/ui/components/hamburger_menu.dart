import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/user_bloc/user_bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HamburgerMenuComponents extends StatefulWidget {
  @override
  _HamburgerMenuComponentsState createState() =>
      _HamburgerMenuComponentsState();
}

class _HamburgerMenuComponentsState extends State<HamburgerMenuComponents> {
  AuthenticationBloc _authBloc;
  UserBloc _userBloc;
  User user;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  void _loginButtonFunction() {
    BlocProvider.of<PageBloc>(context).add(
      PageChanged(
        context: context,
        routeName: LOGIN_URL,
      ),
    );
  }

  void _logoutButtonFunction() {
    _authBloc.add(LoggedOut(context: context));
  }

  void _ticketButtonFunction() {
    BlocProvider.of<PageBloc>(context).add(
      PageChanged(
        context: context,
        routeName: TICKET_URL,
      ),
    );
  }

  void _settingsButtonFunction() {
    BlocProvider.of<PageBloc>(context).add(
      PageChanged(
        context: context,
        routeName: SETTINGS_URL,
      ),
    );
  }

  Widget _buildProfileImage(String profileImage) {
    if (profileImage == null) {
      return Icon(
        Icons.account_circle,
        color: ColorSets.pageBackgroundColor,
      );
    } else {
      return Image.network(
        profileImage,
      );
    }
  }

  Widget _buildProfileHeader(String username, String profileImage) {
    return Column(
      children: [
        Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAlias,
            child: FittedBox(child: _buildProfileImage(profileImage))),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 30.0),
          child: Text(
            username ?? '',
            style:
                TextStyles.subtitle1.copyWith(color: ColorSets.lightTextColor),
          ),
        )
      ],
    );
  }

  Widget _buildHamburgerMenuItem(String menuItemName, dynamic function) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 50,
        color: ColorSets.profilePageThemeColor,
        child: Center(
          child: Text(
            menuItemName,
            style:
                TextStyles.subtitle1.copyWith(color: ColorSets.lightTextColor),
          ),
        ),
      ),
      onTap: () => function(),
    );
  }

  Widget _buildSpacer(double spaceFactor) {
    var _height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: _height * spaceFactor,
    );
  }

  Widget _buildHamburgerMenu() {
    List<Widget> _menuItems = List<Widget>();
    user = _userBloc.userService.currentUser;

    if (_authBloc.state is AuthenticationAuthenticated) {
      _menuItems.add(_buildProfileHeader(user.fullName, user.profilePhoto));
      _menuItems.add(_buildHamburgerMenuItem('TICKETS', _ticketButtonFunction));
      _menuItems
          .add(_buildHamburgerMenuItem('SETTINGS', _settingsButtonFunction));
      _menuItems.add(_buildSpacer(0.2));
      _menuItems.add(_buildHamburgerMenuItem('LOGOUT', _logoutButtonFunction));
    } else {
      _menuItems.add(_buildHamburgerMenuItem('LOGIN', _loginButtonFunction));
      _menuItems
          .add(_buildHamburgerMenuItem('SETTINGS', _settingsButtonFunction));
    }

    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: _menuItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Container(
              color: ColorSets.barBackgroundColor,
              alignment: Alignment.center,
              child: _buildHamburgerMenu(),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
