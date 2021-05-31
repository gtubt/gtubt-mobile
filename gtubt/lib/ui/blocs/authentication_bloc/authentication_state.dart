import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState() : super();
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationUninitialized";
  }

  @override
  List<Object> get props => [];
}

class AuthenticationAuthenticated extends AuthenticationState {
  final String? userEmail;

  AuthenticationAuthenticated({this.userEmail}) : super();

  @override
  String toString() {
    return 'Authenticated {userEmail: $userEmail}';
  }

  @override
  List<Object?> get props => [userEmail];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() {
    return "Unauthenticated";
  }

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationLoading";
  }

  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message);
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "AuthenticationError";
  }
}
