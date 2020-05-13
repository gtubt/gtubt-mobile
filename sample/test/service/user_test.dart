import 'dart:convert';

import 'package:GTUBT/service/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/user.dart';

void main() {
  test('Get User with email', () async {
    User user = await UserService().get("yasir.nacak@gmail.com");
    expect(user == null, false);
    expect(user.name, "Yasir");
  });
}