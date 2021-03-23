import 'package:equatable/equatable.dart';

abstract class AppbarEvent extends Equatable{
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
