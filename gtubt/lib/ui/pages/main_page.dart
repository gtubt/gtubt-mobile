import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_bloc.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_event.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_state.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/authentication_state.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:GTUBT/ui/components/appbar_linear_progress_indicator.dart';
import 'package:GTUBT/ui/components/hamburger_menu.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget? body;

  void _onNavigation(int index) {
    if (context.read<AuthenticationBloc>().state
            is AuthenticationUnauthenticated &&
        index == 2) {
      context.read<PageBloc>().add(
            PageChanged(
              routeName: LOGIN_URL,
              context: context,
            ),
          );
    } else {
      context.read<PageBloc>().add(
            NavBarPageChanged(
              page: index,
              context: context,
            ),
          );
    }
    context.read<AppbarBloc>().add(PageChangedAppbarEvent());
  }

  void _toggleProfileEdit() {
    context.read<AppbarBloc>().add(UserEditButtonPressed());
  }

  /// Returns appbar actions for every page and appbar state.
  List<Widget> _generateActions() {
    var actions = <Widget>[];
    var _selectedPage = context.read<PageBloc>().state;
    var routesList = Routes.bodyTitle;
    if (context.read<AuthenticationBloc>().state
        is AuthenticationAuthenticated) {
      routesList = Routes.bodyTitleLoggedIn;
    }

    if (routesList[_selectedPage.currentPage] == Routes.PROFILE) {
      bool desiredMode = context.read<AppbarBloc>().state.editMode;

      if (desiredMode) {
        actions.add(
            IconButton(icon: Icon(Icons.check), onPressed: _toggleProfileEdit));
      } else {
        actions.add(
            IconButton(icon: Icon(Icons.edit), onPressed: _toggleProfileEdit));
      }
    }

    return actions;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppbarBloc, AppbarState>(builder: (context, state) {
      return BlocBuilder<PageBloc, PageState>(builder: (context, state) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authState) {
          var actions = _generateActions();
          var isLoading =
              context.read<AppbarBloc>().state is AppbarLoadingState;
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                brightness: Brightness.dark,
                iconTheme: IconThemeData(color: ColorSets.lightTextColor),
                backgroundColor: ColorSets.appMainColor,
                title: state.currentPage == 0 ? Image.asset("assets/logo_textless.png", height: 70,)
                    : Text(authState is AuthenticationAuthenticated
                    ? Routes.bodyTitleLoggedIn[state.currentPage]
                    : Routes.bodyTitle[state.currentPage],
                    style: TextStyle(color: ColorSets.lightTextColor),),
                actions: actions,
                bottom: AppBarLinearProgressIndicator(isLoading),
              ),
              bottomNavigationBar: BottomNavigationBar(
                fixedColor: Colors.white,
                selectedFontSize: 12,
                unselectedItemColor: ColorSets.unselectedBarItemColor,
                selectedIconTheme: IconThemeData(
                  color: ColorSets.selectedBarItemColor,
                ),
                unselectedIconTheme: IconThemeData(
                  color: ColorSets.unselectedBarItemColor,
                ),
                currentIndex: state.currentPage,
                backgroundColor: ColorSets.appMainColor,
                onTap: _onNavigation,
                items: authState is AuthenticationAuthenticated
                    ? Routes.navListLoggedIn
                    : Routes.navList,
              ),
              drawer: HamburgerMenuComponents(),
              body: authState is AuthenticationAuthenticated
                  ? Routes.bodyListLoggenIn[state.currentPage]
                  : Routes.bodyList[state.currentPage]);
        });
      });
    });
  }
}
