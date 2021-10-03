import 'dart:convert';

import 'package:GTUBT/exceptions/authentication.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends BaseService {
  static final AuthService _authService = AuthService._internal();

  final servicePath = 'auth';

  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    String url = getUrl(extraServicePath: 'login');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await POST(
        url,
        body: json.encode({
          "username": email,
          "password": password,
        }),
      );
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      String token = decodedResponse['key'];
      prefs.setString("token", token);
      return _authService.getUser();
    } catch (_) {}
    throw AuthenticationException();
  }

  Future<void> reAuthenticate(
    String email,
    String password,
  ) async {
    try {} catch (_) {
      throw AuthenticationException();
    }
  }

  Future<User?> signUp(User user, String password) async {
    try {
      String url = getUrl(extraServicePath: 'registration');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await POST(
        url,
        body: json.encode({
          "username": user.email,
          "first_name": user.first_name,
          "last_name": user.last_name,
          "department": getString(user.department),
          "email": user.email,
          "student_id": "1610440000",
          "password1": password,
          "password2": password,
          "is_accept_kvkk": user.is_accept_kvkk,
          "is_accept_user_agreement": user.is_accept_user_agreement
        }),
      );
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      String token = decodedResponse['key'];
      prefs.setString("token", token);
      return getUser();
    } catch (_) {
      throw AuthenticationException();
    }
  }

  Future<bool> isSignedIn() async {
    if (getUser().runtimeType == User)
      return true;
    else
      return false;
  }

  Future<void> signOut() async {
    String url = getUrl(extraServicePath: 'logout');
    try {
      final response = await POST(url);
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      if (decodedResponse.containsKey("detail") &&
          decodedResponse["detail"] == "Successfully logged out.") {
        return;
      } else {
        throw AuthenticationException();
      }
    } catch (_) {}
    throw AuthenticationException();
  }

  Future<User?> getUser() async {
    String url = getUrl(extraServicePath: 'user');
    try {
      final response = await GET(url);
      if (response.statusCode != 200) {
        // TODO: write special error message!
        throw AuthenticationException();
      }
      return User.fromJson(jsonDecode(response.body));
    } catch (_) {
      throw AuthenticationException();
    }
  }

  Future<String> sendPasswordResetEmail(String email) async {
    String url = getUrl(extraServicePath: 'password/reset');
    try {
      final response = await POST(url);
      if (response.statusCode != 200) {
        throw AuthenticationException.message(
            "Password reset e-mail hasn't been sent. Please try again later.");
      }
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      if (decodedResponse.containsKey("detail"))
        return decodedResponse['detail'];

      return "Password reset e-mail has been sent";
    } catch (_) {
      throw AuthenticationException();
    }
  }

  Future<void> verifyUserWithEmail() async {
    String url = getUrl(extraServicePath: 'registration/verify-email');
    try {

    } catch (e) {
      throw AuthenticationException.message(e.toString());
    }
  }

  bool isVerified() {
    return true;
  }

  Future<void> deleteUser() async {}
}
