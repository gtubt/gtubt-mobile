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

class ShowLoading extends AppbarEvent {
  ShowLoading();

  @override
  String toString() {
    return 'ShowLoading';
  }

  @override
  List<Object> get props => ['ShowLoading'];
}

class HideLoading extends AppbarEvent {
  HideLoading();

  @override
  String toString() {
    return 'HideLoading';
  }

  @override
  List<Object> get props => ['HideLoading'];
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
