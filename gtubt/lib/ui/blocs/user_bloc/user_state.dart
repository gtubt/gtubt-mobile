class UserState {
  String errorMessage;
  bool isFailure;
  UserState({this.errorMessage = '', this.isFailure = false});

  @override
  String toString() {
    return '''User{}''';
  }

  factory UserState.failure(errorMessage) {
    return UserState(
      errorMessage: errorMessage,
      isFailure: true,
    );
  }
}
