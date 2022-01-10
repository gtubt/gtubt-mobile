import 'package:GTUBT/exceptions/user.dart';
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

    return eventMap[field]!;
  }

  @override
  Stream<UserState> mapEventToState(event) async* {
    if (event is PhotoChanged) {
      yield* _mapProfilePhotoChangeToStream(event);
    } else if (event is PhoneChanged) {
      userService.currentUser!.phone = eventMap[event]!.text.trim();
    } else if (event is DepartmentChanged) {
      // TODO: This is waiting for dropdown to be implement and its own controller.
      // NOT Text Controller!!!
      //userService.currentUser!.department = eventMap[event]!.text.trim();
    } else if (event is YearChanged) {
      _processYear(event);
    } else if (event is NameChanged) {
      _processName(event);
    } else if (event is EmailChanged) {
      userService.currentUser!.email = eventMap[event]!.text.trim();
    } else if (event is StudentNumberChanged) {
      userService.currentUser!.student_id = eventMap[event]!.text.trim();
    }

    yield currentState;
  }

  Stream<UserState> _mapProfilePhotoChangeToStream(event) async* {
    yield UserState.loading();
    try {
      var imageBytes = await event.imageFile.readAsBytes();
      var imageType = event.imageFile.path.split('.').last;
      await userService.uploadProfilePhoto(imageBytes, imageType);
      yield UserState();
    } on UserException catch (error) {
      yield UserState.failure(error.message);
    }
  }

  void _processName(event) {
    var fullname = eventMap[event]!.text.trim();
    if (fullname.isNotEmpty) {
      var names = fullname.split(" ");
      if (names.length > 1) {
        userService.currentUser!.last_name = names.last;
        userService.currentUser!.first_name =
            names.sublist(0, names.length - 1).join(" ");
      } else {
        userService.currentUser!.first_name = fullname;
      }
    }
  }

  void _processYear(event) {
    var year = eventMap[event]!.text.trim();
    if (year.isNotEmpty) {
      userService.currentUser!.year =  int.tryParse(year);
    }
  }
}
