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
    
    final response = await POST(
      url,
      body: json.encode({
        "username": email,
        "password": password,
      }),
    );
    Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    if (response.statusCode != 200) {
      if (decodedResponse.containsKey('non_field_errors')){
        throw AuthenticationException.message(decodedResponse['non_field_errors'][0]);
      }
    }
    try {
      String token = decodedResponse['key'];
      prefs.setString("token", token);
      return _authService.getUser();
    } catch (_) {
      // TODO: key must be in decodedResponse so add logger
      throw AuthenticationException();
    }
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
    try {
      getUser();
      return true;
    } on AuthenticationException catch (_) {
      return false;
    } catch (_) {
      // TODO: add logger
      return false;
    }
  }

  Future<void> signOut() async {
    String url = getUrl(extraServicePath: 'logout');
    try {
      // TODO: body?
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

    final response = await GET(url);
    if (response.statusCode != 200) {
      // TODO: write special error message!
      throw AuthenticationException();
    }
    try {
      return User.fromJson(jsonDecode(response.body));
    } catch (_) {
      // TODO: decode error
      throw AuthenticationException();
    }
  }

  Future<String> sendPasswordResetEmail(String email) async {
    String url = getUrl(extraServicePath: 'password/reset');
    try {
      // TODO: body?
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

  Future<void> sendVerificationEmail(String email) async {
    String url = getUrl(extraServicePath: 'registration/resend-email');
    try {
      final response = await POST(url,
          body: json.encode({
            "email": email,
          }));
      if (response.statusCode != 200 ) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        String msg = "";
        if (decodedResponse.containsKey('error_msg')){
          msg = decodedResponse["error_msg"];
        }
        throw AuthenticationException.message(msg);
      }
    } catch (e) {
      throw AuthenticationException.message(e.toString());
    }
  }

  Future<bool> isVerified(int userId) async {
    String url = getUrl(extraServicePath: 'allauth/${userId}/is-email-verified');

    final response = await GET(url);
    Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    if (response.statusCode != 200) {
      String msg = "";
      if (decodedResponse.containsKey('error_msg')) {
        msg = decodedResponse['error_msg'];
      }
      // TODO: check this exception
      throw AuthenticationException.message(msg);
    }
    return decodedResponse['email_verified'] as bool;
  }

  Future<void> deleteUser() async {

  }
}
