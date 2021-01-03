import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserService userService = UserService();
  User editedUser;
  Map<UserEvent, TextEditingController> eventMap = {};

  @override
  get initialState => UserState();

  UserState currentState = UserState();

  TextEditingController textEditingController(UserEvent field) {
    eventMap.putIfAbsent(field, () => TextEditingController());

    return eventMap[field];
  }

  @override
  Stream<UserState> mapEventToState(event) async* {
    // TODO: check all event and send data
    if (event is PhotoChanged) {
      editedUser.profilePhoto = eventMap[event].text.trim();
    } else if (event is PhoneChanged) {
      editedUser.phone = eventMap[event].text.trim();
    } else if (event is ToggleEditMode) {
      if (currentState.editMode) {
        userService.patch(editedUser);
      } else {
        editedUser = User.clone(userService.currentUser);
      }

      currentState = UserState(editMode: !currentState.editMode);
    }

    yield currentState;
  }
}
