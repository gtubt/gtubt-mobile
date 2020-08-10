import 'package:meta/meta.dart';

class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isNameValid;
  final bool isSurnameValid;
  final bool isGradeValid;
  final bool isDepartmentValid;
  final bool isStudentNumberValid;
  final bool isPhoneNumberValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isEmailValid &&
      isPasswordValid &&
      isNameValid &&
      isSurnameValid &&
      isGradeValid &&
      isDepartmentValid &&
      isStudentNumberValid &&
      isPhoneNumberValid;

  RegisterState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isNameValid,
    @required this.isSurnameValid,
    @required this.isGradeValid,
    @required this.isDepartmentValid,
    @required this.isStudentNumberValid,
    @required this.isPhoneNumberValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
        isPasswordValid: true,
        isEmailValid: true,
        isNameValid: true,
        isSurnameValid: true,
        isPhoneNumberValid: true,
        isStudentNumberValid: true,
        isGradeValid: true,
        isDepartmentValid: true,
        isSuccess: false,
        isFailure: false,
        isSubmitting: false);
  }

  factory RegisterState.loading() {
    return RegisterState(
        isPasswordValid: true,
        isEmailValid: true,
        isNameValid: true,
        isSurnameValid: true,
        isPhoneNumberValid: true,
        isStudentNumberValid: true,
        isGradeValid: true,
        isDepartmentValid: true,
        isSuccess: false,
        isFailure: false,
        isSubmitting: true);
  }

  factory RegisterState.failure() {
    return RegisterState(
        isPasswordValid: true,
        isEmailValid: true,
        isNameValid: true,
        isSurnameValid: true,
        isPhoneNumberValid: true,
        isStudentNumberValid: true,
        isGradeValid: true,
        isDepartmentValid: true,
        isSuccess: false,
        isFailure: true,
        isSubmitting: false);
  }

  factory RegisterState.success() {
    return RegisterState(
        isPasswordValid: true,
        isEmailValid: true,
        isNameValid: true,
        isSurnameValid: true,
        isPhoneNumberValid: true,
        isStudentNumberValid: true,
        isGradeValid: true,
        isDepartmentValid: true,
        isSuccess: true,
        isFailure: false,
        isSubmitting: false);
  }

  RegisterState copyWith({
    bool isPasswordValid,
    bool isEmailValid,
    bool isNameValid,
    bool isSurnameValid,
    bool isPhoneNumberValid,
    bool isStudentNumberValid,
    bool isGradeValid,
    bool isDepartmentValid,
    bool isSuccess,
    bool isFailure,
    bool isSubmitting,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isSurnameValid: isSurnameValid ?? this.isSurnameValid,
      isGradeValid: isGradeValid ?? this.isGradeValid,
      isDepartmentValid: isDepartmentValid ?? this.isDepartmentValid,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isStudentNumberValid: isStudentNumberValid ?? this.isStudentNumberValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  RegisterState update({
    bool isPasswordValid,
    bool isEmailValid,
    bool isNameValid,
    bool isSurnameValid,
    bool isPhoneNumberValid,
    bool isStudentNumberValid,
    bool isGradeValid,
    bool isDepartmentValid,
  }) {
    return copyWith(
      isPasswordValid: isPasswordValid,
      isEmailValid: isEmailValid,
      isNameValid: isNameValid,
      isSurnameValid: isSurnameValid,
      isPhoneNumberValid: isPhoneNumberValid,
      isStudentNumberValid: isStudentNumberValid,
      isGradeValid: isGradeValid,
      isDepartmentValid: isDepartmentValid,
      isSuccess: false,
      isFailure: false,
      isSubmitting: false,
    );
  }

  @override
  String toString() {
    return '''RegisterState =>  
      isPasswordValid: $isPasswordValid,
      isEmailValid: $isEmailValid,
      isNameValid: $isNameValid,
      isSurnameValid: $isSurnameValid,
      isPhoneNumberValid: $isPhoneNumberValid,
      isStudentNumberValid: $isStudentNumberValid,
      isGradeValid: $isGradeValid,
      isDepartmentValid: $isDepartmentValid,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isSubmitting: $isSubmitting,
    ''';
  }
}
