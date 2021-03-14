import 'package:GTUBT/service/authentication.dart';
import 'package:GTUBT/service/user.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  AuthenticationBloc();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    bool isSignedIn = await _authService.isSignedIn();
    try {
      if (isSignedIn) {
        auth.User firebaseUser = await _authService.getUser();
        await _userService.get(firebaseUser.email);
        yield AuthenticationAuthenticated(userEmail: firebaseUser.email);
      } else {
        yield AuthenticationUnauthenticated();
      }
    } catch (_) {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(event) async* {
    auth.User firebaseUser = await _authService.getUser();
    await _userService.get(firebaseUser.email);
    Navigator.pushNamedAndRemoveUntil(
        event.context, ROOT_URL, (route) => false);
    yield AuthenticationAuthenticated(userEmail: firebaseUser.email);
  }

  Stream<AuthenticationState> _mapLoggedOutToState(event) async* {
    await _authService.signOut();
    _userService.clearUser();
    Navigator.pushNamedAndRemoveUntil(
        event.context, ROOT_URL, (route) => false);
    yield AuthenticationUnauthenticated();
  }
}
