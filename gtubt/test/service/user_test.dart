import 'package:GTUBT/service/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/user.dart';

void main() {
  test('Get User with email', () async {
    User? user = await UserService().get("yasir.nacak@gmail.com");
    expect(user == null, false);
    expect(user!.name, "Yasir");
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

    User? newUser = await UserService().post(user);
    expect(newUser == null, false);
    expect(newUser!.studentId, user.studentId);
  });

  test('Update User', () async {
    User? user = await UserService().get("ahmtergn5@gmail.com");
    expect(user == null, false);
    expect(user!.name, "Ahmet");

    user.phone = "5464351277";

    User? updatedUser = await UserService().patch(user);
    expect(updatedUser == null, false);
    expect(updatedUser!.phone, "5464351277");

    user = await UserService().get("ahmtergn5@gmail.com");
    expect(user == null, false);
    expect(user!.phone, "0546 435 12 77");
  });

  test('Delete User', () async {
    User? user = await UserService().get("ahmtergn5@gmail.com");
    
    expect(user == null, false);
    expect(user!.name, "Ahmet");

    bool isDeleted = await UserService().delete(user.email!);
    expect(isDeleted, true);
  });
}
