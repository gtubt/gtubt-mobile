import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/authentication.dart';
import 'package:GTUBT/service/user.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  AuthService authService = AuthService();
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
  final TextEditingController passwordController = TextEditingController();

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
    else if(event is OnAccountDeletion){
      var reauthUser = await authService.reAuthenticate(userService.currentUser.email, passwordController.text);
      if(reauthUser != null){
          userService.delete(userService.currentUser.id);
          authService.deleteUser();
          Navigator.pushReplacementNamed(event.context, LOGIN_URL);

      }
      else{
        print("USERS DONT MATCH");
      }
    }

    yield currentState;
  }
}
