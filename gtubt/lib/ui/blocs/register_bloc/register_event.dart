import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super();
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

class NameChanged extends RegisterEvent {
  final String name;

  NameChanged({@required this.name});

  @override
  String toString() {
    return 'NameChanged{username: $name}';
  }

  @override
  List<Object> get props => [name];
}

class LastnameChanged extends RegisterEvent {
  final String lastname;

  LastnameChanged({@required this.lastname});

  @override
  String toString() {
    return 'LastnameChanged{username: $lastname}';
  }

  @override
  List<Object> get props => [lastname];
}

class StudentNumberChanged extends RegisterEvent {
  final String studentNumber;

  StudentNumberChanged({@required this.studentNumber});

  @override
  String toString() {
    return 'StudentNumberChanged {studentNumber: $studentNumber}';
  }

  @override
  List<Object> get props => [studentNumber];
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password});

  @override
  String toString() {
    return 'PasswordChanged {password: $password}';
  }

  @override
  List<Object> get props => [password];
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  final String lastname;
  final String studentNumber;
  final bool isAcceptKVKK;
  final bool isAcceptUserAgreement;

  Submitted(
      {@required this.name,
      @required this.lastname,
      @required this.password,
      @required this.email,
      @required this.studentNumber,
      @required this.isAcceptKVKK,
      @required this.isAcceptUserAgreement});

  @override
  String toString() {
    return 'Submitted{email: $email, username: $name, studentNumber: $studentNumber}';
  }

  @override
  List<Object> get props => [
        name,
        lastname,
        email,
        password,
        studentNumber,
      ];
}
