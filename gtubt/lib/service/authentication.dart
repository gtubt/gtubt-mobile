import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:GTUBT/exceptions/authentication.dart';
import 'package:GTUBT/models/user.dart';
import 'package:kiwi/kiwi.dart';
import 'package:GTUBT/service/service.dart';

class AuthService extends BaseService {
  final servicePath = 'auth';
  static final AuthService _authService = AuthService._internal();
  AuthService._internal();
  KiwiContainer container = KiwiContainer();

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
      return getUser();
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

  Future<User?> signUp(Map<String, dynamic> data) async {
    try {} catch (_) {
      throw AuthenticationException();
    }
  }

  Future<bool> isSignedIn() async {
    return false;
  }

  Future<void> signOut() async {}

  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '$baseUrl/$endpointPrefix/$servicePath/user/';
    String? token = prefs.getString("token");
    final userInfo = await GET(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "token": "token $token",
      },
    );
    return User.fromJson(jsonDecode(userInfo.body));
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
