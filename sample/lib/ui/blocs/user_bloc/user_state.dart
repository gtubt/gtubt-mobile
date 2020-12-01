import 'package:GTUBT/models/user.dart';
import 'package:flutter/foundation.dart';

class UserState {
  User user;
  User updatedUser;
  bool editMode;

  UserState({
    @required this.user,
    this.editMode = false,
  });

  factory UserState.loggedOut() {
    return UserState(user: null, editMode: false);
  }
  factory UserState.nullState() {
    return UserState(
      user: null,
      editMode: false,
    );
  }
  factory UserState.initial(User user) {
    return UserState(
      user: user,
      editMode: false,
    );
  }

  @override
  String toString() {
    return '''User { 
      $user,
      editMode: $editMode,
    }''';
  }
}
