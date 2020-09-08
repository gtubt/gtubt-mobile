import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final AuthService _authService = AuthService._internal();

  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

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

  Future<FirebaseUser> signUp(Map<String, dynamic> data) async {
    final FirebaseUser firebaseUser =
        (await _auth.createUserWithEmailAndPassword(
                email: data['email'], password: data['password']))
            .user;

    // TODO: create user
    return firebaseUser;
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
