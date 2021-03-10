import 'package:GTUBT/models/user.dart';
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
    auth.User firebaseUser;
    if (isSignedIn) {
      var result = await _authService.getUser();
      if (result.isLeft()) {
        auth.User firebaseUser = result as auth.User;
        await _userService.get(firebaseUser.email);
      } else {
        var error = result as AuthFailure;
        yield AuthenticationError(error.toString());
        yield AuthenticationAuthenticated(userEmail: firebaseUser.email);
      }
    } else {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(event) async* {
    var result = await _authService.getUser();
    auth.User firebaseUser;
    if (result.isLeft()) {
      firebaseUser = result as auth.User;
      var getResult = await _userService.get(firebaseUser.email);
      if (getResult.isLeft()) {
        User user = getResult as User;
      } else {
        var error = getResult as AuthFailure;
        yield AuthenticationError(error.toString());
        yield AuthenticationUnauthenticated();
      }
    } else {
      var error = result as AuthFailure;
      yield AuthenticationError(error.toString());
      Navigator.pushReplacementNamed(event.context, ROOT_URL);
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState(event) async* {
    await _authService.signOut();
    _userService.clearUser();
    Navigator.pushReplacementNamed(event.context, ROOT_URL);
    yield AuthenticationUnauthenticated();
  }
}
