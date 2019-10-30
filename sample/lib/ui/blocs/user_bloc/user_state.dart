import 'package:GTUBT/models/user.dart';
import 'package:flutter/foundation.dart';

class UserState {
  final User user;

  UserState({
    @required this.user,
  });

  @override
  String toString() {
    return '''User { 
      $user
    }''';
  }
}
