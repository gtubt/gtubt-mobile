import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:GTUBT/service/base.dart';
import 'dart:convert';

class UserService extends BaseService{

   final servicePath = 'user';

  Future<User> getUser(String email) async {
    String url = '$baseUrl/$endpointPrefix/$email';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final apiResponse = ApiResponseSingle<User>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        return apiResponse.body;
      }
    }
  }
}