import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/user.dart';

void main() {
  test('Serialize User', () {
    User user = User(
      student_id: '161044057',
      email : 'test@test.com',
      first_name: "Test Name",
        last_name: "Test lastname",
      phone : "+905551234567",
      department : Department.eee,
      year : 4);

    expect(user.toJson(),
      json.decode('{"name":"Test Name","lastname":"Test lastname","email":"test@test.com","department":"eee","year":4,"id":null,"studentId":"161044057","phone":"+905551234567","profilePhoto":null}'));
  });

  test('Deserialize User', () {
    User user = User(
      email : 'test@test.com',
      student_id: "161044057",
        first_name: "Test Name",
        last_name: "Test lastname",
      phone : "+905551234567",
      department : Department.cse,
      year : 4);

    Map<String, dynamic> data = json.decode('{"name":"Test Name","lastname":"Test lastname","email":"test@test.com","department":"cse","year":4,"studentId":"161044057","phone":"+905551234567"}');

    expect(user.email, User.fromJson(data).email);
    expect(user.student_id, User.fromJson(data).student_id);
    expect(user.first_name, User.fromJson(data).first_name);
    expect(user.last_name, User.fromJson(data).last_name);
    expect(user.phone, User.fromJson(data).phone);
    expect(user.department, User.fromJson(data).department);
    expect(user.year, User.fromJson(data).year);
  });

  test('Update User', () {
    User user = User(
      email : 'test@test.com',
      student_id: "161044057",
        first_name: "Test Name",
        last_name: "Test lastname",
      phone : "+905551234567",
      department : Department.cse,
      year : 4);

    user.year = 3;

    expect(user.year, 3);
    expect(user.email, "test@test.com");
  });
}