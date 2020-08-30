import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/service/base.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostService extends BaseService {
  static final PostService _postService = PostService._internal();
  final servicePath = 'posts';
  PostService._internal();

  factory PostService() {
    return _postService;
  }

  Future<List<Post>> getAll() async {
    String url = '$baseUrl/$endpointPrefix/$servicePath';

    final response = await http.get('$url');

    if (response.statusCode == 200) {
      final apiResponse = ApiResponseList<Post>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        return apiResponse.body;
      }
    }

    return List<Post>();
  }

  Future<Post> get(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await http.get('$url');

    if (response.statusCode == 200) {
      final apiResponse = ApiResponseSingle<Post>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        return apiResponse.body;
      }
    }

    return null;
  }

  Future<http.Response> post(Post post) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath';
    var postInJson = post.toJson();
    var bodyData = json.encode(postInJson);

    final response = await http.post(
      '$url',
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyData
    );

    return response;
  }
}