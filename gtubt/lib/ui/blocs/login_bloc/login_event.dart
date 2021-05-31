import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent() : super();
}

class EmailChanged extends LoginEvent {
  EmailChanged() : super();

  @override
  String toString() {
    return 'EmailChanged';
  }

  @override
  List<Object> get props => ["Email"];
}

class PasswordChanged extends LoginEvent {
  PasswordChanged() : super();

  @override
  String toString() {
    return 'PasswordChanged';
  }

  @override
  List<Object> get props => ["Password"];
}

class Submitted extends LoginEvent {
  Submitted() : super();

  @override
  String toString() {
    return 'Submitted';
  }

  @override
  List<Object> get props => ["Submitted"];
}

class LoginWithCredentialsPressed extends LoginEvent {
  LoginWithCredentialsPressed() : super();

  @override
  String toString() {
    return 'LoginButtonPressed';
  }

  @override
  List<Object> get props => ["Login"];
}

class ForgotPasswordPressed extends LoginEvent {
  final String email;

  ForgotPasswordPressed({required this.email}) : super();

  @override
  String toString() {
    return 'ForgotPasswordPressed {username: $email}';
  }

  @override
  List<Object> get props => [email];
}
