import 'package:GTUBT/models/user.dart';
import 'package:flutter/foundation.dart';

class UserState {
  final User user;
  final bool editMode;
  UserState({
    @required this.user,
    this.editMode=false,
  });

  @override
  String toString() {
    return '''User { 
      $user,
      editMode: $editMode,
    }''';
  }
}
