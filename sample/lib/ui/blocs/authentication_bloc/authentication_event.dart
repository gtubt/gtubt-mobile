import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent() : super();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() {
    return 'AppStarted';
  }

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final BuildContext context;

  LoggedIn({@required this.context});

  @override
  String toString() {
    return 'LoggedIn';
  }

  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() {
    return 'LoggedOut';
  }

  @override
  List<Object> get props => [];
}
