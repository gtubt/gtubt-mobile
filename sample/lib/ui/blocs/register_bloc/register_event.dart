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

class SurnameChanged extends RegisterEvent {
  final String surname;

  SurnameChanged({@required this.surname});

  @override
  String toString() {
    return 'SurnameChanged{username: $surname}';
  }

  @override
  List<Object> get props => [surname];
}

class ClassChanged extends RegisterEvent {
  final String grade;

  ClassChanged({@required this.grade});

  @override
  String toString() {
    return 'ClassChanged {grade: $grade}';
  }

  @override
  List<Object> get props => [grade];
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

class PhoneNumberChanged extends RegisterEvent {
  final String phoneNumber;

  PhoneNumberChanged({@required this.phoneNumber});

  @override
  String toString() {
    return 'PhoneNumberChanged {phoneNumber: $phoneNumber}';
  }

  @override
  List<Object> get props => [phoneNumber];
}

class DepartmentChanged extends RegisterEvent {
  final String department;

  DepartmentChanged({@required this.department});

  @override
  String toString() {
    return 'DepartmentChanged {department: $department}';
  }

  @override
  List<Object> get props => [department];
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
  final String surname;
  final String grade;
  final String department;
  final String phoneNumber;
  final String studentNumber;

  Submitted({
    @required this.name,
    @required this.surname,
    @required this.password,
    @required this.email,
    @required this.grade,
    @required this.department,
    @required this.phoneNumber,
    @required this.studentNumber,
  });

  @override
  String toString() {
    return 'Submitted{email: $email, username: $name, studentNumber: $studentNumber}';
  }

  @override
  List<Object> get props => [
        name,
        surname,
        email,
        password,
        grade,
        department,
        phoneNumber,
        studentNumber
      ];
}
