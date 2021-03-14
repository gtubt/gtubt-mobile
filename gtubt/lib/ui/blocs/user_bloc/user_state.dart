class UserState {
  bool passwordsMatch;
  UserState({
    this.passwordsMatch = true,
  });

  @override
  String toString() {
    return '''User { 
      
      passwordsMatch: $passwordsMatch
    }''';
  }
}
