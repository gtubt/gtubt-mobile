import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:GTUBT/exceptions/authentication.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/service.dart';
import 'package:GTUBT/service/user.dart';

class AuthService extends BaseService {
  final servicePath = 'auth';
  static final AuthService _authService = AuthService._internal();
  AuthService._internal();
  static final UserService _userService = UserService();

  factory AuthService() {
    return _authService;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/login/';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await POST(
        '$url',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "username": email,
          "password": password,
        }),
      );
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      String token = decodedResponse['key'];
      prefs.setString("token", token);
      return _userService.get();
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
      String url = '$baseUrl/$endpointPrefix/$servicePath/registration/';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await POST(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
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
    String url = '$baseUrl/$endpointPrefix/$servicePath/logout/';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String token = prefs.getString("token")!;
      final response = await POST(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "token $token",
        },
      );
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '$baseUrl/$endpointPrefix/$servicePath/user/';
    try {
      String token = prefs.getString("token")!;
      final userInfo = await GET(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "token $token",
        },
      );
      return User.fromJson(jsonDecode(userInfo.body));
    } catch (_) {
      throw AuthenticationException();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {} catch (_) {
      throw AuthenticationException();
    }
  }

  Future<void> validateUserWithEmail() async {
    try {} catch (e) {
      throw AuthenticationException.message(e.toString());
    }
  }

  bool isVerified() {
    return true;
  }

  Future<void> deleteUser() async {}
}
