import 'package:GTUBT/exceptions/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:kiwi/kiwi.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  static final AuthService _authService = AuthService._internal();
  AuthService._internal();
  KiwiContainer container = KiwiContainer();

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
      container.registerInstance<auth.User>(_auth.currentUser);
      return firebaseUser;
    } on auth.FirebaseAuthException catch (error) {
      throw AuthenticationException.errorCode(error.code);
    } catch (error) {
      try {
        container.unregister<auth.User>();
      } catch (_) {}

      throw AuthenticationException();
    }
  }

  Future<void> reAuthenticate(
    String email,
    String password,
  ) async {
    try {
      auth.EmailAuthCredential credential =
          auth.EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser.reauthenticateWithCredential(credential);
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
      container.registerInstance<auth.User>(_auth.currentUser);
      return firebaseUser;
    } on auth.FirebaseAuthException catch (error) {
      throw AuthenticationException.errorCode(error.code);
    } catch (_) {
      throw AuthenticationException();
    }
  }

  Future<bool> isSignedIn() async {
    if (_auth.currentUser != null) {
      container.registerInstance<auth.User>(_auth.currentUser);
    }
    return _auth.currentUser != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    container.unregister<auth.User>();
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

  Future<void> validateUserWithEmail() async {
    try {
      await _auth.currentUser.sendEmailVerification();
    } catch (e) {
      throw AuthenticationException.message(e.toString());
    }
  }

  bool isVerified() {
    if (!_auth.currentUser.emailVerified) {
      return false;
    }
    return true;
  }

  Future<void> deleteUser() async {
    try {
      container.unregister<auth.User>();
    } catch (_) {}
    await _auth.currentUser.delete();
  }
}
