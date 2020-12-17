import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:GTUBT/service/base.dart';
import 'dart:convert';

class UserService extends BaseService {
  final servicePath = 'user';

  Future<User> get(String email) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$email';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final apiResponse =
          ApiResponseSingle<User>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        return apiResponse.body;
      }
    }
    return null;
  }

  Future<http.Response> post(User user) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath';
    var userJson = user.toJson();
    var bodyData = json.encode(userJson);

    final response = await http.post('$url',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyData);

    return response;
  }

  Future<http.Response> patch(User user) async {
    var id = user.id;
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';
    var userJson = user.toJson();
    var bodyData = json.encode(userJson);

    final response = await http.patch('$url',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyData);

    return response;
  }

  Future<http.Response> delete(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await http.delete('$url');

    return response;
  }
}
