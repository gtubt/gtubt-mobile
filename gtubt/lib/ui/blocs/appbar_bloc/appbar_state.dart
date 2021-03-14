class AppbarState {
  bool editMode = false;

  AppbarState({this.editMode = false});

  @override
  String toString() {
    return '''AppbarState {EditMode: $editMode}''';
  }
}