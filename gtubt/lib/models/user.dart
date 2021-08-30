library user;

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? first_name;
  String? last_name;
  String? email;
  Department? department;
  int? year;
  int? id;
  String? student_id;
  String? phone;
  bool? is_accept_kvkk;
  bool? is_accept_user_agreement;
  bool? is_email_verified;

  @JsonKey(name: "photo")
  String? photo;

  User({
    this.id,
    this.student_id,
    this.email,
    this.first_name,
    this.last_name,
    this.department,
    this.year,
    this.phone,
    this.photo,
    this.is_accept_kvkk,
    this.is_accept_user_agreement,
    this.is_email_verified,
  });

  String get fullName => "$first_name $last_name";

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String?, dynamic> toJson() => _$UserToJson(this);

  factory User.clone(User user) {
    return User(
      student_id: user.student_id,
      email: user.email,
      department: user.department,
      first_name: user.first_name,
      last_name: user.last_name,
      year: user.year,
      phone: user.phone,
      photo: user.photo,
      id: user.id,
      is_accept_kvkk: user.is_accept_kvkk,
      is_accept_user_agreement: user.is_accept_user_agreement,
      is_email_verified: user.is_email_verified,
    );
  }

  @override
  String toString() {
    return '''User {  
    Name: $first_name,
    Lastname: $last_name, 
    Email: $email,
    Department: $department,
    Year: $year,
    Student ID: $student_id,
    Phone: $phone,
    Photo Url: $photo,
    Is Accept KVKK: $is_accept_kvkk,
    Is Accept User Agreement: $is_accept_user_agreement,
    Is Email Verified: $is_email_verified,
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
