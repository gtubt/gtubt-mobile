import 'package:GTUBT/service/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/user.dart';
import 'package:http/http.dart';

void main() {
  test('Get User with email', () async {
    var result = await UserService().get("yasir.nacak@gmail.com");
    User user = result.fold(
            (user) => user,
            (userFailure) => null
    );
    expect(user == null, false);
    expect(user.name, "Yasir");
  });

  test('Post User', () async {
    User user = new User();
    user.studentId = "161044011";
    user.name = "Ahmet";
    user.lastname = "Ergani";
    user.email = "ahmtergn5@gmail.com";
    user.department = Department.cse;
    user.phone = "5464351276";
    user.year = 2016;
    user.profilePhoto = "google.com";

    Response response = await UserService().post(user);
    expect(response == null, false);
    expect(response.statusCode, 200);
  });

  test('Update User', () async {
    var result = await UserService().get("ahmtergn5@gmail.com");
    User user = result.fold(
            (user) => user,
            (userFailure) => null
    );
    expect(user == null, false);
    expect(user.name, "Ahmet");

    user.phone = "5464351277";

    Response response = await UserService().patch(user);
    expect(response == null, false);
    expect(response.statusCode, 200);

    result = await UserService().get("ahmtergn5@gmail.com");
    user = result.fold(
            (user) => user,
            (userFailure) => null
    );
    expect(user == null, false);
    expect(user.phone, "0546 435 12 77");
  });

  test('Delete User', () async {
    var result = await UserService().get("ahmtergn5@gmail.com");
    User user = result.fold(
            (user) => user,
            (userFailure) => null
    );
    expect(user == null, false);
    expect(user.name, "Ahmet");

    var id = user.id;
    Response response = await UserService().delete(id);
    expect(response == null, false);
    expect(response.statusCode, 200);
  });
}
