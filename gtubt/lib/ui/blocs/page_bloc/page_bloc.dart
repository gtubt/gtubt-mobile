import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'page_event.dart';
import 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  get initialState => PageState(currentPage: 0);

  @override
  Stream<PageState> mapEventToState(event) async* {
    if (event is NavBarPageChanged) {
      yield PageState(currentPage: event.page);
    } else if (event is PageChanged) {
      Navigator.of(event.context).pushNamed(event.routeName);
      yield PageState(currentPage: 0);
    }
  }
}
