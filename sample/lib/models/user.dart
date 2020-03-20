library user;
import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:GTUBT/models/core/serializers.dart';

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

abstract class User implements Built<User, UserBuilder> {
  String get name;
  String get lastname;
  String get email;
  
  @nullable
  Department get department;
  
  @nullable
  int get year;
  
  @nullable
  String get id;
  
  @nullable
  String get phone;
  
  @nullable
  String get profilePhoto;

  User._();

  factory User([updates(UserBuilder b)]) = _$User;

  String toJson() {
    return json.encode(serializers.serializeWith(User.serializer, this));
  }

  static User fromJson(String jsonString) {
    return serializers.deserializeWith(User.serializer, json.decode(jsonString));
  }

  static Serializer<User> get serializer => _$userSerializer;

  @override
  String toString() {
    return '''User {  
    Name: $name,
    Lastname: $lastname, 
    Email: $email,
    Department: $department,
    Year: $year,
    Student ID: $id,
    Phone: $phone,
    Photo Url: $profilePhoto
}''';
  }
}

class Department extends EnumClass {
  static const Department cse = _$cse;

  const Department._(String name) : super(name);

  static BuiltSet<Department> get values => _$values;
  static Department valueOf(String name) => _$valueOf(name);

  static Serializer<Department> get serializer => _$departmentSerializer;
}