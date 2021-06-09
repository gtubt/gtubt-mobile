library user;

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? name;
  String? lastname;
  String? email;
  Department? department;
  int? year;
  int? id;
  String? studentId;
  String? phone;
  bool? isAcceptKVKK;
  bool? isAcceptUserAgreement;

  @JsonKey(name: "photoUrl")
  String? profilePhoto;

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
    this.isAcceptKVKK,
    this.isAcceptUserAgreement,
  });

  String get fullName => "$name $lastname";

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String?, dynamic> toJson() => _$UserToJson(this);

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
      isAcceptKVKK: user.isAcceptKVKK,
      isAcceptUserAgreement: user.isAcceptUserAgreement,
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
    Photo Url: $profilePhoto,
    Is Accept KVKK: $isAcceptKVKK,
    Is Accept User Agreement: $isAcceptUserAgreement,
}''';
  }
}

enum Department { cse, eee }

String? getString(Department? department) {
  switch (department) {
    case Department.cse:
      return "Computer Engineering";
    case Department.eee:
      return "Electronic Engineering";
    default:
      return "";
  }
}
