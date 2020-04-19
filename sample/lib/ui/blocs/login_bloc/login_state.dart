import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginState extends Equatable {
  final String email;
  LoginState([List props = const [], this.email]) : super(props);
}

class LoginUninitialized extends LoginState {
  @override
  String toString() {
    return 'LoginUninitialized';
  }
}

class LoginLoading extends LoginState {
  @override
  String toString() {
    return 'LoginLoading';
  }
}

class LoginFailure extends LoginState {
  @override
  String toString() {
    return 'LoginFailure';
  }
}

class LoginSuccess extends LoginState {
  @override
  String toString() {
    return 'LoginSuccess';
  }
}

class LoginUpdate extends LoginState {
  LoginUpdate(email) : super([email]);

  @override
  String toString() {
    return "LoginUpdate";
  }
}