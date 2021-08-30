class ContactPreferencesState {
  bool isEmailValid;
  bool isPasswordValid;
  bool isSubmitting;
  bool isSuccess;
  bool isFailure;
  bool isPwRequestSent;
  bool? isForgotButton;
  String? errorMessage;
  String? loadingMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  ContactPreferencesState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.isPwRequestSent,
    this.isForgotButton,
    this.errorMessage,
    this.loadingMessage,
  });

  factory ContactPreferencesState.empty() {
    return ContactPreferencesState(
      isEmailValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
      isPwRequestSent: false,
    );
  }

  factory ContactPreferencesState.loading(loadingMessage) {
    return ContactPreferencesState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
      isPwRequestSent: false,
      loadingMessage: loadingMessage,
    );
  }

  factory ContactPreferencesState.failForgotPassword(errorMessage) {
    return ContactPreferencesState(
      isEmailValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
      isPwRequestSent: false,
      errorMessage: errorMessage,
    );
  }

  factory ContactPreferencesState.failure(errorMessage) {
    return ContactPreferencesState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
      isPwRequestSent: false,
      errorMessage: errorMessage,
    );
  }

  factory ContactPreferencesState.success() {
    return ContactPreferencesState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isFailure: false,
      isSuccess: true,
      isPwRequestSent: false,
    );
  }

  ContactPreferencesState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isPwRequestSent,
  }) {
    return ContactPreferencesState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      isPwRequestSent: isPwRequestSent ?? this.isPwRequestSent,
    );
  }

  ContactPreferencesState update({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isPwRequestSent,
    bool? isFailure,
    String? loadingMesssage,
    String? errorMessage,
  }) {
    return ContactPreferencesState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: false,
      isFailure: isFailure ?? false,
      isSuccess: false,
      isPwRequestSent: isPwRequestSent ?? false,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''ContactPreferencesState {
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
