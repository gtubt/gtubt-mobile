import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class PageEvent extends Equatable {
  PageEvent() : super();
}

class PageChanged extends PageEvent {
  final int page;

  PageChanged({@required this.page}) : super();

  @override
  String toString() => 'PageChanged { Page :$page }';

  @override
  List<Object> get props => [page];
}
