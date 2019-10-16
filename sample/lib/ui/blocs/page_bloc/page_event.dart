import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
// import 'page_state.dart';

abstract class PageEvent extends Equatable {
  PageEvent([List props = const []]) : super(props);
}

class PageChanged extends PageEvent {
  final int page;

  PageChanged({@required this.page}) : super([page]);

  @override
  String toString() => 'PageChanged { Page :$page }';
}