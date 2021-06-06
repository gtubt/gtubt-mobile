import 'dart:convert';

import 'package:GTUBT/exceptions/user.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/service.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:kiwi/kiwi.dart';


class UserService extends BaseService {
  final servicePath = 'users';
  User? currentUser;
  User? userBackup;
  KiwiContainer container = KiwiContainer();
  static final UserService _userService = UserService._internal();

  UserService._internal();

  factory UserService() {
    return _userService;
  }

  Future<User?> get(String email) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$email';
    final response = await GET(url);
    var apiResponse;
    if (response.statusCode != 200) {
      throw UserException();
    }
    try {
      apiResponse =
          ApiResponseSingle<User>.fromJson(json.decode(response.body));

      if (apiResponse.status != 200) {
        throw UserException.message(apiResponse.message);
      }

      this.currentUser = apiResponse.body;
      return apiResponse.body;
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
      apiResponse =
          ApiResponseSingle<User>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw UserException.message(apiResponse.message);
      }
      currentUser = apiResponse.body;
      return apiResponse.body;
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  Future<User?> patch(User user) async {
    var id = user.id;
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id/';
    try {
      var firebaseUser = container.resolve<auth.User>();
      if (firebaseUser.email != user.email) {
        firebaseUser.updateEmail(user.email!);
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

      apiResponse =
          ApiResponseSingle<User>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw UserException.message(apiResponse.message);
      }
      currentUser = apiResponse.body;
      return apiResponse.body;
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

      apiResponse =
          ApiResponseSingle<User>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw UserException.message(apiResponse.message);
      }

      currentUser = apiResponse.body;
      return apiResponse.body;
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  Future<bool> delete(String email) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$email';
    var apiResponse;

    final response = await DELETE('$url');
    if (response.statusCode != 200) {
      throw UserException();
    }
    try {
      apiResponse = ApiResponse.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw UserException.message(apiResponse.message);
      }
      clearUser();
      return true;
    } on UserException catch (ex) {
      throw UserException(ex.message);
    } catch (_) {
      throw UserException();
    }
  }

  void clearUser() {
    currentUser = null;
  }
}
