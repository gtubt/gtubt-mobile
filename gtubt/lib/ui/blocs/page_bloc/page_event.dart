import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class PageEvent extends Equatable {
  PageEvent() : super();
}

class NavBarPageChanged extends PageEvent {
  final int page;
  final BuildContext context;

  NavBarPageChanged({@required this.page, @required this.context}) : super();

  @override
  String toString() => 'PageChanged { Page :$page }';

  @override
  List<Object> get props => [page, context];
}

class PageChanged extends PageEvent {
  final BuildContext context;
  final String routeName;
  bool isRoutingActive;

  PageChanged({
    @required this.context,
    @required this.routeName,
    this.isRoutingActive = true,
  });

  @override
  String toString() => 'PageChanged {routeName: $routeName}';

  @override
  List<Object> get props => [context, routeName];
}
