import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthFailure {
  final String message;

  AuthFailure(this.message);

  @override
  String toString() => message;
}

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  static final AuthService _authService = AuthService._internal();

  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  // sign in with email and password
  Future<Either<auth.User, AuthFailure>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return Left((await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user);
    } catch (error) {
      return Right(AuthFailure("Could not sign in"));
    }
  }

  Future<Either<auth.User, AuthFailure>> signUp(
      Map<String, dynamic> data) async {
    try {
      final auth.User firebaseUser =
          (await _auth.createUserWithEmailAndPassword(
                  email: data['email'], password: data['password']))
              .user;
      return Left(firebaseUser);
    } catch (error) {
      return Right(AuthFailure("Could not create account"));
    }
  }

  Future<bool> isSignedIn() async {
    return _auth.currentUser != null;
  }

  Future<Either<void, AuthFailure>> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      return Right(AuthFailure("Could not Sign Out"));
    }
    return Right(AuthFailure("Could not Sign Out"));
  }

  Future<Either<auth.User, AuthFailure>> getUser() async {
    try {
      return left(_auth.currentUser);
    } catch (e) {
      return Right(AuthFailure("Could not get User"));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
