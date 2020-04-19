import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/user.dart';

void main() {
  test('Serialize User', () {
    User user = User(
      id: '161044057',
      email : 'test@test.com',
      name : "Test Name",
      lastName : "Test LastName",
      phone : "+905551234567",
      department : Department.cse,
      year : 4);

    expect(user.toJson(),
      '{"name":"Test Name","lastname":"Test LastName","email":"test@test.com","department":"cse","year":4,"id":161044057,"phone":"+905551234567"}');
  });

  test('Deserialize User', () {
    User user = User(
      email : 'test@test.com',
      id : "161044057",
      name : "Test Name",
      lastName : "Test LastName",
      phone : "+905551234567",
      department : Department.cse,
      year : 4);

    Map<String, dynamic> data = json.decode('{"name":"Test Name","lastName":"Test LastName","email":"test@test.com","department":"cse","year":4,"id":"161044057","phone":"+905551234567"}');

    expect(user.email, User.fromJson(data).email);
    expect(user.id, User.fromJson(data).id);
    expect(user.name, User.fromJson(data).name);
    expect(user.lastName, User.fromJson(data).lastName);
    expect(user.phone, User.fromJson(data).phone);
    expect(user.department, User.fromJson(data).department);
    expect(user.year, User.fromJson(data).year);
  });

  test('Update User', () {
    User user = User(
      email : 'test@test.com',
      id : "161044057",
      name : "Test Name",
      lastName : "Test LastName",
      phone : "+905551234567",
      department : Department.cse,
      year : 4);

    user.year = 3;

    expect(user.year, 3);
    expect(user.email, "test@test.com");
  });
}