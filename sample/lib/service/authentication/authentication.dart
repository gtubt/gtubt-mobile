import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService({FirebaseAuth firebaseAuth})
      : _auth = firebaseAuth ?? FirebaseAuth.instance;

  // sign in with email and password
  Future<FirebaseUser> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<bool> isSignedIn() async {
    return (await _auth.currentUser()) != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<FirebaseUser> getUser() async {
      return await _auth.currentUser();
  }
}
