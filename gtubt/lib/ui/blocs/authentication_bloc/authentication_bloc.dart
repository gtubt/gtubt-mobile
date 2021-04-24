import 'package:GTUBT/exceptions/authentication.dart';
import 'package:GTUBT/exceptions/user.dart';
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
  AuthenticationBloc() : super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    } else if (event is DeleteAcc) {
      yield* _mapDeleteAccToState(event.password);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    bool isSignedIn = await _authService.isSignedIn();
    auth.User firebaseUser;
    if (isSignedIn) {
      try {
        firebaseUser = _authService.getUser();
        await _userService.get(firebaseUser.email);
        yield AuthenticationAuthenticated(userEmail: firebaseUser.email);
      } on AuthenticationException catch (_) {
        yield AuthenticationUnauthenticated();
      } on UserException catch (_) {
        if (firebaseUser != null) {
          _authService.signOut();
          yield AuthenticationUnauthenticated();
        } else {
          yield AuthenticationUnauthenticated();
        }
      }
    } else {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(event) async* {
    try {
      auth.User firebaseUser = _authService.getUser();
      await _userService.get(firebaseUser.email);
      Navigator.pushNamedAndRemoveUntil(
          event.context, MAIN_URL, (route) => false);
      yield AuthenticationAuthenticated(userEmail: firebaseUser.email);
    } on AuthenticationException catch (error) {
      yield* _handleLoggedInExceptions(error.message, event.context);
    } on UserException catch (error) {
      yield* _handleLoggedInExceptions(error.message, event.context);
    }
  }

  Stream<AuthenticationState> _handleLoggedInExceptions(
      String message, BuildContext context) async* {
    yield AuthenticationError(message);
    Navigator.pushNamedAndRemoveUntil(context, MAIN_URL, (route) => false);
    yield AuthenticationUnauthenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState(event) async* {
    await _authService.signOut();
    _userService.clearUser();
    Navigator.pushNamedAndRemoveUntil(
        event.context, MAIN_URL, (route) => false);
    yield AuthenticationUnauthenticated();
  }

  Stream<AuthenticationState> _mapDeleteAccToState(String password) async* {
    try {
      await _authService.reAuthenticate(
          _userService.currentUser.email, password);
      await _userService.delete(_userService.currentUser.email);
      await _authService.deleteUser();
      yield AuthenticationUnauthenticated();
    } on AuthenticationException catch (error) {
      yield AuthenticationError(error.message);
    } on UserException catch (error) {
      yield AuthenticationError(error.message);
    } on auth.FirebaseAuthException catch (_) {
      yield AuthenticationError('Please login again!');
    }
  }
}
