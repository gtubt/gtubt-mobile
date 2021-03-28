import 'package:GTUBT/exceptions/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  static final AuthService _authService = AuthService._internal();
  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  Future<auth.User> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final auth.User firebaseUser = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      KiwiContainer container = KiwiContainer();
      container.clear();
      container.registerInstance<auth.User>(_auth.currentUser,
          name: "firebaseUser");
      return firebaseUser;
    } on auth.FirebaseAuthException catch (error) {
      throw AuthenticationException.errorCode(error.code);
    } catch (_) {
      throw AuthenticationException();
    }
  }

  Future<auth.User> signUp(Map<String, dynamic> data) async {
    try {
      final auth.User firebaseUser =
          (await _auth.createUserWithEmailAndPassword(
                  email: data['email'], password: data['password']))
              .user;

      return firebaseUser;
    } on auth.FirebaseAuthException catch (error) {
      throw AuthenticationException.errorCode(error.code);
    } catch (_) {
      throw AuthenticationException();
    }
  }

  Future<bool> isSignedIn() async {
    KiwiContainer container = KiwiContainer();
    container.clear();
    container.registerInstance<auth.User>(_auth.currentUser,
        name: "firebaseUser");
    return _auth.currentUser != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    KiwiContainer container = KiwiContainer();
    container.clear();
  }

  auth.User getUser() {
    auth.User user = _auth.currentUser;
    if (user == null) {
      throw AuthenticationException();
    }
    return user;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
