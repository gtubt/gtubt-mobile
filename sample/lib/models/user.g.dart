// GENERATED CODE - DO NOT MODIFY BY HAND

part of user;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    studentId: json['studentId'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    lastname: json['lastname'] as String,
    department: _$enumDecodeNullable(_$DepartmentEnumMap, json['department']),
    year: json['year'] as int,
    phone: json['phone'] as String,
    profilePhoto: json['profilePhoto'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'lastname': instance.lastname,
      'email': instance.email,
      'department': _$DepartmentEnumMap[instance.department],
      'year': instance.year,
      'id': instance.id,
      'studentId': instance.studentId,
      'phone': instance.phone,
      'profilePhoto': instance.profilePhoto,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DepartmentEnumMap = {
  Department.cse: 'cse',
};
