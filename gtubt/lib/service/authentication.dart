import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  static final AuthService _authService = AuthService._internal();

  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  // sign in with email and password
  Future<auth.User> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (error) {
      return null;
    }
  }

  Future<auth.User> reAuthenticate(
      String email,
      String password,
      ) async {
    try {
      EmailAuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      return (await _auth.currentUser.reauthenticateWithCredential(credential)).user;
    } catch (error) {
      return null;
    }
  }

  Future<auth.User> signUp(Map<String, dynamic> data) async {
    final auth.User firebaseUser =
        (await _auth.createUserWithEmailAndPassword(
                email: data['email'], password: data['password']))
            .user;

    return firebaseUser;
  }

  Future<bool> isSignedIn() async {
    return  _auth.currentUser != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<auth.User> getUser() async {
    return _auth.currentUser;
  }

   Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> deleteUser() async{
    await _auth.currentUser.delete();
  }


}
