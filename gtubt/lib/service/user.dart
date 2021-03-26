import 'package:GTUBT/exceptions/user.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/service/service.dart';
import 'dart:convert';

class UserService extends BaseService {
  final servicePath = 'user';
  User currentUser;
  static final UserService _userService = UserService._internal();

  UserService._internal();

  factory UserService() {
    return _userService;
  }

  Future<User> get(String email) async {
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
    } catch (_) {
      throw UserException();
    }
  }

  Future<User> post(User user) async {
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
    } catch (_) {
      throw UserException();
    }
  }

  Future<User> patch(User user) async {
    var id = user.id;
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id/';
    try {
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
      // TODO: Fire some userBloc event to update current profile page with new user data
      return apiResponse.body;
    } catch (_) {
      throw UserException();
    }
  }

  Future<bool> delete(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';
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
    } catch (_) {
      throw UserException();
    }
  }

  void clearUser() {
    currentUser = null;
  }
}
