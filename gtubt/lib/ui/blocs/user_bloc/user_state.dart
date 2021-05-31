class UserState {
  String errorMessage;
  String loadingMessage;
  bool isFailure;
  bool isLoading;

  UserState({
    this.errorMessage = '',
    this.isFailure = false,
    this.isLoading = false,
    this.loadingMessage = '',
  });

  @override
  String toString() {
    return '''
      isFailure: $isFailure,
      errorMessage: $errorMessage
    }''';
  }

  factory UserState.failure(errorMessage) {
    return UserState(
      errorMessage: errorMessage,
      isFailure: true,
    );
  }

  factory UserState.loading({loadingMessage}) {
    return UserState(
      isLoading: true,
      loadingMessage: loadingMessage
    );
  }
}
