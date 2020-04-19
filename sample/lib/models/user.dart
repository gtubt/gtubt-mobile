library user;

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// Usage for Built Models:
///
/// User((b) => b
///     ..name = 'John'
///     ..lastname = 'Doe'
///     ..email = 'john@doe.com'
///     ..department = Department.cse);
///
/// Name, Lastname and Email is required.

@JsonSerializable()
class User {
  String name;
  String lastName;
  String email;
  String id;

  @JsonKey(nullable: true)
  Department department;

  @JsonKey(nullable: true)
  int year;

  @JsonKey(nullable: true)
  String phone;

  @JsonKey(nullable: true)
  String profilePhoto;

  User({
    this.id,
    this.email,
    this.name,
    this.lastName,
    this.department,
    this.year,
    this.phone,
    this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return '''User {  
    Name: $name,
    Lastname: $lastName, 
    Email: $email,
    Department: $department,
    Year: $year,
    Student ID: $id,
    Phone: $phone,
    Photo Url: $profilePhoto
}''';
  }
}

enum Department { cse }
