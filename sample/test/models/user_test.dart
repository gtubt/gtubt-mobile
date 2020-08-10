import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/user.dart';

void main() {
  test('Serialize User', () {
    User user = User(
      studentId: '161044057',
      email : 'test@test.com',
      name : "Test Name",
      lastname : "Test lastname",
      phone : "+905551234567",
      department : Department.cse,
      year : 4);

    expect(user.toJson(),
      json.decode('{"name":"Test Name","lastname":"Test lastname","email":"test@test.com","department":"cse","year":4,"id":null,"studentId":"161044057","phone":"+905551234567","profilePhoto":null}'));
  });

  test('Deserialize User', () {
    User user = User(
      email : 'test@test.com',
      studentId : "161044057",
      name : "Test Name",
      lastname : "Test lastname",
      phone : "+905551234567",
      department : Department.cse,
      year : 4);

    Map<String, dynamic> data = json.decode('{"name":"Test Name","lastname":"Test lastname","email":"test@test.com","department":"cse","year":4,"studentId":"161044057","phone":"+905551234567"}');

    expect(user.email, User.fromJson(data).email);
    expect(user.studentId, User.fromJson(data).id);
    expect(user.name, User.fromJson(data).name);
    expect(user.lastname, User.fromJson(data).lastname);
    expect(user.phone, User.fromJson(data).phone);
    expect(user.department, User.fromJson(data).department);
    expect(user.year, User.fromJson(data).year);
  });

  test('Update User', () {
    User user = User(
      email : 'test@test.com',
      studentId : "161044057",
      name : "Test Name",
      lastname : "Test lastname",
      phone : "+905551234567",
      department : Department.cse,
      year : 4);

    user.year = 3;

    expect(user.year, 3);
    expect(user.email, "test@test.com");
  });
}