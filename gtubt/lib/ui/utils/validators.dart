import 'package:GTUBT/models/user.dart';
import 'package:basic_utils/basic_utils.dart';

class Validators {
  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$");
  static final RegExp _passwordRegExp =
      RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

  static final RegExp _stringRegExp = RegExp(r"^[A-Za-z0-9-ğüşıöçĞÜŞİÖÇ\s.]+$");

  static final RegExp _phoneRegExp = RegExp(r"^(?:[+0]9)?[0-9]{10}$");

  static final RegExp _studentNumRegExp = RegExp(r"^[0-9]{8,10}");

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidString(String str) {
    return _stringRegExp.hasMatch(str);
  }

  static isValidDepartment(Department department) {
    return department != null;
  }

  static isValidDigit(String digit) {
    return StringUtils.isDigit(digit);
  }

  static isValidPhoneNumber(String phoneNumber) {
    return _phoneRegExp.hasMatch(phoneNumber);
  }

  static isValidStudentNumber(String studentNumber) {
    return _studentNumRegExp.hasMatch(studentNumber);
  }
}
