import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AppbarEvent {
  AppbarEvent() : super();
}

class UserEditButtonPressed extends AppbarEvent {
  UserEditButtonPressed();

  @override
  String toString() {
    return 'UserEditButtonPressed';
  }

  @override
  List<Object> get props => ['UserEditButtonPressed'];
}

class PageChangedAppbarEvent extends AppbarEvent {
  PageChangedAppbarEvent();

  @override
  String toString() {
    return 'PageChangedAppbarEvent';
  }

  @override
  List<Object> get props => ['PageChangedAppbarEvent'];
}
