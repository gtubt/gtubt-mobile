class UserState {
  bool editMode;
  bool doesPasswordMatch;
  UserState({
    this.editMode = false,
    this.doesPasswordMatch = true,
  });

  @override
  String toString() {
    return '''User { 
      editMode: $editMode,
    }''';
  }
}
