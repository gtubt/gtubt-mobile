import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/user.dart';

void main() {
  test('Serialize User', () {
    User user = User((user) => user
      ..email = 'test@test.com'
      ..id = 161044057
      ..name = "Test Name"
      ..lastname = "Test LastName"
      ..phone = "+905551234567"
      ..department = Department.cse
      ..year = 4);

    expect(user.toJson(),
      '{"name":"Test Name","lastname":"Test LastName","email":"test@test.com","department":"cse","year":4,"id":161044057,"phone":"+905551234567"}');
  });

  test('Deserialize User', () {
    User user = User((user) => user
      ..email = 'test@test.com'
      ..id = 161044057
      ..name = "Test Name"
      ..lastname = "Test LastName"
      ..phone = "+905551234567"
      ..department = Department.cse
      ..year = 4);

    expect(user,
      User.fromJson('{"name":"Test Name","lastname":"Test LastName","email":"test@test.com","department":"cse","year":4,"id":161044057,"phone":"+905551234567"}'));
  });

  test('Update User', () {
    User user = User((user) => user
      ..email = 'test@test.com'
      ..id = 161044057
      ..name = "Test Name"
      ..lastname = "Test LastName"
      ..phone = "+905551234567"
      ..department = Department.cse
      ..year = 4);

    user = user.rebuild((b) => b
    ..year = 3);

    expect(user.year, 3);
    expect(user.email, "test@test.com");
  });
}