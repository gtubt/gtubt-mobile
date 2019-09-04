import 'package:GTUBT/models/department.dart';

class User {
  String name;
  String lastname;
  String email;
  Department department;
  int year;
  int id;
  String phone;
  String profilePhoto;

  User();

  @override
  String toString() {
    return '''Name: $name,
    Lastname: $lastname, 
    Email: $email,
    Department: $department,
    Year: $year,
    Student ID: $id,
    Phone: $phone,
    Photo Url: $profilePhoto''';
  }
}