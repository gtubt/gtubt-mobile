import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() {
    return 'AppStarted';
  }
}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() {
    return 'LoggedIn';
  }
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() {
    return 'LoggedOut';
  }
}