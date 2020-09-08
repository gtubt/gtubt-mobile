import 'package:GTUBT/service/authentication.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService = AuthService();

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
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    bool isSignedIn = await _authService.isSignedIn();
    try {
      if (isSignedIn) {
        FirebaseUser firebaseUser = await _authService.getUser();
        yield AuthenticationAuthenticated(userEmail: firebaseUser.email);
      } else {
        yield AuthenticationUnauthenticated();
      }
    } catch (_) {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(event) async* {
    FirebaseUser firebaseUser = await _authService.getUser();
    Navigator.pushReplacementNamed(event.context, ROOT_URL);
    yield AuthenticationAuthenticated(userEmail: firebaseUser.email);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await _authService.signOut();
    yield AuthenticationUnauthenticated();
  }
}
