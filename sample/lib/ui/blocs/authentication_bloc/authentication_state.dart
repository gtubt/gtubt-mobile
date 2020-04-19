import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationUninitialized";
  }
}

class AuthenticationAuthenticated extends AuthenticationState {
  final String userEmail;

  AuthenticationAuthenticated({this.userEmail}) : super([userEmail]);

  @override
  String toString() {
    return 'Authenticated {userEmail: $userEmail}';
  }
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() {
    return "Unauthenticated";
  }
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationLoading";
  }
}
