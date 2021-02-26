class UserState {
  bool editMode;
  bool passwordsMatch;
  UserState({
    this.editMode = false,
    this.passwordsMatch = true,
  });

  @override
  String toString() {
    return '''User { 
      editMode: $editMode,
      passwordsMatch: $passwordsMatch
    }''';
  }
}
