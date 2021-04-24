import 'package:meta/meta.dart';

class LoginState {
  bool isEmailValid;
  bool isPasswordValid;
  bool isSubmitting;
  bool isSuccess;
  bool isFailure;
  bool isPwRequestSent;
  String errorMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isPwRequestSent,
    this.errorMessage,
  });

  factory LoginState.empty() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
      isPwRequestSent: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
      isPwRequestSent: false,
    );
  }

  factory LoginState.failure(errorMessage) {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
      isPwRequestSent: false,
      errorMessage: errorMessage,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isFailure: false,
      isSuccess: true,
      isPwRequestSent: false,
    );
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isPwRequestSent,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      isPwRequestSent: isPwRequestSent ?? this.isPwRequestSent,
    );
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isPwRequestSent,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
      isPwRequestSent: isPwRequestSent ?? this.isPwRequestSent,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isPwRequestSent: $isPwRequestSent,
      errorMessage: $errorMessage
    }''';
  }
}
