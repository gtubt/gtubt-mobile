import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppbarState extends Equatable{
  final editMode;

  AppbarState({this.editMode = false});

  @override
  String toString() {
    return '''AppbarState {EditMode: $editMode}''';
  }

  @override
  List<Object> get props => [];
}

class AppbarErrorState extends AppbarState{

  @override
  List<Object> get props => [];
}