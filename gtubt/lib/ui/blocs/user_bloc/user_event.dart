import 'package:GTUBT/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class UserEvent extends Equatable {
  final String field;

  UserEvent({@required this.field}) : super();

  @override
  List<Object> get props => [field];
}

class PhotoChanged extends UserEvent {

  PhotoChanged() : super(field: 'Photo');

  @override
  String toString() => 'Profile Photo Changed';
}

class PhoneChanged extends UserEvent {

  PhoneChanged() : super(field: 'Phone');

  @override
  String toString() => 'User Changed Phone';

}

class YearChanged extends UserEvent {

  YearChanged() : super(field: 'Year');

  @override
  String toString() => 'User Changed Year';

}

class StudentNumberChanged extends UserEvent {

  StudentNumberChanged() : super(field: 'StudentNumber');

  @override
  String toString() => 'User Changed Student Number';

}

class EmailChanged extends UserEvent {

  EmailChanged() : super(field: 'Email');

  @override
  String toString() => 'User Changed Email';

}

class DepartmentChanged extends UserEvent {

  DepartmentChanged() : super(field: 'Department');

  @override
  String toString() => 'User Changed Department';
}

class OnAccountDeletion extends UserEvent{
  final BuildContext context;

  OnAccountDeletion({@required this.context}): super(field:'');

  @override
  String toString() => 'On Account Deletion';
}
