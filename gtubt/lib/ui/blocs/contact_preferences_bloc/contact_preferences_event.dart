import 'package:equatable/equatable.dart';

abstract class ContactPreferencesEvent extends Equatable {
  ContactPreferencesEvent() : super();
}

class EmailChanged extends ContactPreferencesEvent {
  EmailChanged() : super();

  @override
  String toString() {
    return 'EmailChanged';
  }

  @override
  List<Object> get props => ["Email"];
}

class PasswordChanged extends ContactPreferencesEvent {
  PasswordChanged() : super();

  @override
  String toString() {
    return 'PasswordChanged';
  }

  @override
  List<Object> get props => ["Password"];
}

class Submitted extends ContactPreferencesEvent {
  Submitted() : super();

  @override
  String toString() {
    return 'Submitted';
  }

  @override
  List<Object> get props => ["Submitted"];
}

class LoginWithCredentialsPressed extends ContactPreferencesEvent {
  LoginWithCredentialsPressed() : super();

  @override
  String toString() {
    return 'LoginButtonPressed';
  }

  @override
  List<Object> get props => ["Login"];
}

class ForgotPasswordPressed extends ContactPreferencesEvent {
  final String email;

  ForgotPasswordPressed({required this.email}) : super();

  @override
  String toString() {
    return 'ForgotPasswordPressed {username: $email}';
  }

  @override
  List<Object> get props => [email];
}
