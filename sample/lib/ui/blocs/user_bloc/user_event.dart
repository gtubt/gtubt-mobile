import 'package:GTUBT/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class UserEvent extends Equatable {
  UserEvent() : super();
}

class PhotoChanged extends UserEvent {
  final String url;

  PhotoChanged({@required this.url}) : super();

  @override
  String toString() => 'Profile Photo Changed { Url :$url }';

  @override
  List<Object> get props => [url];
}

class GetUser extends UserEvent {
  GetUser() : super();

  @override
  String toString() => 'GetUser';

  @override
  List<Object> get props => [];
}

class UserLoggedIn extends UserEvent {
  final User user;

  UserLoggedIn({@required this.user}) : super();

  @override
  String toString() => 'User Logged In { User: $user }';

  @override
  List<Object> get props => [user];
}

class PhoneChanged extends UserEvent {
  final String phone;

  PhoneChanged({@required this.phone}) : super();

  @override
  String toString() => 'User Changed Phone { Phone: $phone }';

  @override
  List<Object> get props => [phone];
}

class ToggleEditMode extends UserEvent {
  ToggleEditMode() : super();

  @override
  String toString() => 'Toggle Edit Mode';

  @override
  List<Object> get props => [];
}

class UserUpdate extends UserEvent {
  final User user;
  UserUpdate(this.user) : super();

  @override
  String toString() {
    return 'Update User $user';
  }

  @override
  List<Object> get props => [user];
}
