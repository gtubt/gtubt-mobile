// GENERATED CODE - DO NOT MODIFY BY HAND

part of user;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Department _$cse = const Department._('cse');

Department _$valueOf(String name) {
  switch (name) {
    case 'cse':
      return _$cse;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Department> _$values =
    new BuiltSet<Department>(const <Department>[
  _$cse,
]);

Serializer<User> _$userSerializer = new _$UserSerializer();
Serializer<Department> _$departmentSerializer = new _$DepartmentSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'lastname',
      serializers.serialize(object.lastname,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
    ];
    if (object.department != null) {
      result
        ..add('department')
        ..add(serializers.serialize(object.department,
            specifiedType: const FullType(Department)));
    }
    if (object.year != null) {
      result
        ..add('year')
        ..add(serializers.serialize(object.year,
            specifiedType: const FullType(int)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.phone != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(object.phone,
            specifiedType: const FullType(String)));
    }
    if (object.profilePhoto != null) {
      result
        ..add('profilePhoto')
        ..add(serializers.serialize(object.profilePhoto,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lastname':
          result.lastname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'department':
          result.department = serializers.deserialize(value,
              specifiedType: const FullType(Department)) as Department;
          break;
        case 'year':
          result.year = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'profilePhoto':
          result.profilePhoto = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$DepartmentSerializer implements PrimitiveSerializer<Department> {
  @override
  final Iterable<Type> types = const <Type>[Department];
  @override
  final String wireName = 'Department';

  @override
  Object serialize(Serializers serializers, Department object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Department deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Department.valueOf(serialized as String);
}

class _$User extends User {
  @override
  final String name;
  @override
  final String lastname;
  @override
  final String email;
  @override
  final Department department;
  @override
  final int year;
  @override
  final String id;
  @override
  final String phone;
  @override
  final String profilePhoto;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.name,
      this.lastname,
      this.email,
      this.department,
      this.year,
      this.id,
      this.phone,
      this.profilePhoto})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('User', 'name');
    }
    if (lastname == null) {
      throw new BuiltValueNullFieldError('User', 'lastname');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('User', 'email');
    }
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        name == other.name &&
        lastname == other.lastname &&
        email == other.email &&
        department == other.department &&
        year == other.year &&
        id == other.id &&
        phone == other.phone &&
        profilePhoto == other.profilePhoto;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, name.hashCode), lastname.hashCode),
                            email.hashCode),
                        department.hashCode),
                    year.hashCode),
                id.hashCode),
            phone.hashCode),
        profilePhoto.hashCode));
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _lastname;
  String get lastname => _$this._lastname;
  set lastname(String lastname) => _$this._lastname = lastname;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  Department _department;
  Department get department => _$this._department;
  set department(Department department) => _$this._department = department;

  int _year;
  int get year => _$this._year;
  set year(int year) => _$this._year = year;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _profilePhoto;
  String get profilePhoto => _$this._profilePhoto;
  set profilePhoto(String profilePhoto) => _$this._profilePhoto = profilePhoto;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _lastname = _$v.lastname;
      _email = _$v.email;
      _department = _$v.department;
      _year = _$v.year;
      _id = _$v.id;
      _phone = _$v.phone;
      _profilePhoto = _$v.profilePhoto;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            name: name,
            lastname: lastname,
            email: email,
            department: department,
            year: year,
            id: id,
            phone: phone,
            profilePhoto: profilePhoto);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
