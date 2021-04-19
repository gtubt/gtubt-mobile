library user;

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;
  String lastname;
  String email;

  @JsonKey(nullable: true)
  Department department;

  @JsonKey(nullable: true)
  int year;

  int id;
  String studentId;

  @JsonKey(nullable: true)
  String phone;

  @JsonKey(nullable: true)
  String profilePhoto;

  User({
    this.id,
    this.studentId,
    this.email,
    this.name,
    this.lastname,
    this.department,
    this.year,
    this.phone,
    this.profilePhoto,
  });

  String get fullName => "$name $lastname";

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.clone(User user) {
    return User(
      studentId: user.studentId,
      email: user.email,
      department: user.department,
      name: user.name,
      lastname: user.lastname,
      year: user.year,
      phone: user.phone,
      profilePhoto: user.profilePhoto,
      id: user.id,
    );
  }


  @override
  String toString() {
    return '''User {  
    Name: $name,
    Lastname: $lastname, 
    Email: $email,
    Department: $department,
    Year: $year,
    Student ID: $studentId,
    Phone: $phone,
    Photo Url: $profilePhoto
}''';
  }
}

enum Department {
  cse,
  eee
}
