import 'package:equatable/equatable.dart';

class AppbarState extends Equatable {
  final editMode;

  AppbarState({this.editMode = false});

  @override
  String toString() {
    return '''AppbarState {EditMode: $editMode}''';
  }

  @override
  List<Object> get props => [editMode];
}

class AppbarErrorState extends AppbarState {
  @override
  List<Object> get props => ["AppbarErrorState"];
}

class AppbarLoadingState extends AppbarState {
  @override
  List<Object> get props => ["AppbarLoadingState"];
}
