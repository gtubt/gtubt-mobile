import 'dart:convert';

import 'package:GTUBT/exceptions/user.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/service.dart';
import 'package:GTUBT/service/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends BaseService {
  AuthService auth = AuthService();
  final servicePath = 'users';
  User? currentUser;
  User? userBackup;
  static final UserService _userService = UserService._internal();

  UserService._internal();

  factory UserService() {
    return _userService;
  }

  Future<User?> get() async {
    try {
      this.currentUser = await auth.getUser();
      return await auth.getUser();
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  Future<User?> post(User user) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/';
    try {
      var userJson = user.toJson();
      var bodyData = json.encode(userJson);
      var apiResponse;

      final response = await POST('$url',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData);
      if (response.statusCode != 200) {
        throw UserException(response.body);
      }
      apiResponse = User.fromJson(json.decode(response.body));
      currentUser = apiResponse;
      return apiResponse;
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  Future<User?> patch(User user) async {
    var id = user.id;
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id/';
    User? firebaseUser = await auth.getUser();
    try {
      if (firebaseUser?.email != user.email) {
        PATCH(
          url,
          body: json.encode({
            "email": user.email,
          }),
        );
        // TODO: Might throw requires-recent-login,
        // TODO: needs design for password retrieval for such events
      }

      var userJson = user.toJson();
      var bodyData = json.encode(userJson);
      var apiResponse;

      final response = await PATCH('$url',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData);

      if (response.statusCode != 200) {
        throw UserException();
      }

      apiResponse = User.fromJson(json.decode(response.body));

      currentUser = apiResponse;
      return apiResponse;
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  Future<User> uploadProfilePhoto(dynamic photo, String imageType) async {
    var email = currentUser!.email;
    String url = '$baseUrl/$endpointPrefix/$servicePath/$email/photo';
    try {
      var apiResponse;
      final response = await POST('$url',
          headers: <String, String>{
            'Content-Type': 'image/$imageType',
          },
          body: photo);

      if (response.statusCode != 200) {
        throw UserException(json.decode(response.body)["Message"]);
      }

      apiResponse = User.fromJson(json.decode(response.body));

      currentUser = apiResponse;
      return apiResponse;
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  Future<bool> delete(String email) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$email';

    final response = await DELETE('$url');
    if (response.statusCode != 200) {
      throw UserException();
    }
    try {
      clearUser();
      return true;
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  void clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    currentUser = null;
  }
}
