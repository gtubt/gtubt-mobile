import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent() : super();
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email}) : super();

  @override
  String toString() {
    return 'PasswordChanged {username: $email}';
  }

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password}) : super();

  @override
  String toString() {
    return 'PasswordChanged {password: $password}';
  }

  @override
  List<Object> get props => [password];
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password}) : super();

  @override
  String toString() {
    return 'Submitted {username: $email, password: $password}';
  }

  @override
  List<Object> get props => [email, password];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({@required this.email, @required this.password})
      : super();

  @override
  String toString() {
    return 'LoginButtonPressed {username: $email, password: $password}';
  }

  @override
  List<Object> get props => [email, password];
}
