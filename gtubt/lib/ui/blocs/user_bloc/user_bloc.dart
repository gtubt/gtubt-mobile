import 'package:GTUBT/service/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserService userService = UserService();
  Map<UserEvent, TextEditingController> eventMap = {};

  UserBloc() : super(UserState());

  UserState currentState = UserState();

  TextEditingController textEditingController(UserEvent field) {
    eventMap.putIfAbsent(field, () => TextEditingController());

    return eventMap[field];
  }

  @override
  Stream<UserState> mapEventToState(event) async* {
    if (event is PhotoChanged) {
      userService.currentUser.profilePhoto = eventMap[event].text.trim();
    } else if (event is PhoneChanged) {
      userService.currentUser.phone = eventMap[event].text.trim();
    }
    yield currentState;
  }
}
