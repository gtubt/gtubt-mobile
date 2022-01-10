import 'package:GTUBT/service/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/user.dart';

void main() {
  test('Get User with email', () async {
    User? user = await UserService().get();
    expect(user == null, false);
    expect(user!.first_name, "Yasir");
  });

  test('Post User', () async {
    User user = new User();
    user.student_id = "161044011";
    user.first_name = "Ahmet";
    user.last_name = "Ergani";
    user.email = "ahmtergn5@gmail.com";
    user.department = Department.cse;
    user.phone = "5464351276";
    user.year = 2016;
    user.photo = "google.com";

    User? newUser = await UserService().post(user);
    expect(newUser == null, false);
    expect(newUser!.student_id, user.student_id);
  });

  test('Update User', () async {
    User? user = await UserService().get();
    expect(user == null, false);
    expect(user!.first_name, "Ahmet");

    user.phone = "5464351277";

    User? updatedUser = await UserService().patch(user);
    expect(updatedUser == null, false);
    expect(updatedUser!.phone, "5464351277");

    user = await UserService().get();
    expect(user == null, false);
    expect(user!.phone, "0546 435 12 77");
  });

  test('Delete User', () async {
    User? user = await UserService().get();
    
    expect(user == null, false);
    expect(user!.first_name, "Ahmet");

    bool isDeleted = await UserService().delete(user.email!);
    expect(isDeleted, true);
  });
}
