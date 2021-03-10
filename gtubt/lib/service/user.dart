import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/service/event.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:GTUBT/service/base.dart';
import 'dart:convert';

class UserFailure {
  final String message;

  UserFailure(this.message);

  @override
  String toString() => message;
}

class UserService extends BaseService {
  final servicePath = 'user';
  User currentUser;
  static final UserService _userService = UserService._internal();

  UserService._internal();

  factory UserService() {
    return _userService;
  }

  Future<Either<User, UserFailure>> get(String email) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$email';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final apiResponse =
          ApiResponseSingle<User>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        currentUser = apiResponse.body;
        return Left(apiResponse.body);
      }
    }
    return Right(UserFailure("Couldn't find the user 😱"));
  }

  Future<Either<User, UserFailure>> post(User user) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/';
    var userJson = user.toJson();
    var bodyData = json.encode(userJson);

    final response = await http.post('$url',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyData);
    if (response.statusCode == 200) {
      final apiResponse =
          ApiResponseSingle<User>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        currentUser = apiResponse.body;
        return left(apiResponse.body);
      }
    }
    return right(UserFailure("Couldn't find the user 😱"));
  }

  Future<Either<User, UserFailure>> patch(User user) async {
    var id = user.id;
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id/';
    var userJson = user.toJson();
    var bodyData = json.encode(userJson);

    final response = await http.patch('$url',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyData);
    if (response.statusCode == 200) {
      final apiResponse =
          ApiResponseSingle<User>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        currentUser = apiResponse.body;
        // TODO: Fire some userBloc event to update current profile page with new user data
        return left(apiResponse.body);
      }
    }
    return right(UserFailure("Couldn't update the user 😱"));
  }

  Future<Either<bool, UserFailure>> delete(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await http.delete('$url');
    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        currentUser = null;
        return left(true);
      }
    }
    return right(UserFailure("Couldn't delete the user 😱"));
  }

  void clearUser() {
    currentUser = null;
  }
}
