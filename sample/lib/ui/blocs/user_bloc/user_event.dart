import 'package:GTUBT/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
// import 'user_state.dart';

abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);
}

class PhotoChanged extends UserEvent {
  final String url;

  PhotoChanged({@required this.url}) : super([url]);

  @override
  String toString() => 'Profile Photo Changed { Url :$url }';
}

class LoggedIn extends UserEvent {
  final User user;

  LoggedIn({@required this.user}) : super([user]);

  @override
  String toString() => 'User Logged In { User: $user }';
}

class PhoneChanged extends UserEvent {
  final String phone;

  PhoneChanged({@required this.phone}) : super([phone]);

  @override
  String toString() => 'User Changed Phone { Phone: $phone }';
}
