class UserState {
  bool passwordsMatch;
  String errorMessage;
  bool isFailure;

  UserState({
    this.errorMessage = '',
    this.isFailure = false,
    this.passwordsMatch = true,
  });

  @override
  String toString() {
    return '''User { 
      
      passwordsMatch: $passwordsMatch
    }''';
  }

  factory UserState.failure(errorMessage) {
    return UserState(
      errorMessage: errorMessage,
      isFailure: true,
    );
  }
}
