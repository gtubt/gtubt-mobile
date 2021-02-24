class UserState {
  bool editMode;
  UserState({
    this.editMode = false,
  });

  @override
  String toString() {
    return '''User { 
      editMode: $editMode,
    }''';
  }
}
