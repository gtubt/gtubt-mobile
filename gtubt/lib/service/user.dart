import 'dart:convert';

import 'package:GTUBT/exceptions/user.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/authentication.dart';
import 'package:GTUBT/service/service.dart';
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
      // TODO: get user from user endpoint
      // this.currentUser = await auth.getUser();
      // return await auth.getUser();
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  Future<User?> post(User user) async {
    String url = getUrl();
    try {
      var userJson = user.toJson();
      var bodyData = json.encode(userJson);
      var apiResponse;

      final response = await POST(url, body: bodyData);
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
    String url = getUrl(extraServicePath: user.id.toString());
    // TODO: refactor: get user from user endpoint
    try {
      Map<String?, dynamic> userJson = user.toJson();
      String bodyData = json.encode(userJson);

      final response = await PATCH(url, body: bodyData);

      if (response.statusCode != 200) {
        throw UserException();
      }

      User updatedUser = User.fromJson(json.decode(response.body));

      currentUser = updatedUser;
      return updatedUser;
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  Future<User> uploadProfilePhoto(dynamic photo, String imageType) async {
    String url = getUrl(extraServicePath: '${currentUser!.email}/photo');
    try {
      final response = await POST(url, body: photo);

      if (response.statusCode != 200) {
        throw UserException(json.decode(response.body)["Message"]);
      }

      User updatedUser = User.fromJson(json.decode(response.body));

      currentUser = updatedUser;
      return updatedUser;
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  Future<bool> delete(String email) async {
    String url = getUrl(extraServicePath: email);
    final response = await DELETE(url);
    if (response.statusCode != 200) {
      throw UserException(
          "User delete operation is not successful! Please try again later.");
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
