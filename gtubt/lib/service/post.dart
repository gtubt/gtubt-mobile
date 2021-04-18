import 'package:GTUBT/exceptions/post.dart';
import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/service/service.dart';
import 'dart:convert';

class PostService extends BaseService {
  static final PostService _postService = PostService._internal();
  final servicePath = 'posts';
  PostService._internal();

  factory PostService() {
    return _postService;
  }

  Future<List<Post>> getAll() async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/all/';

    final response = await GET('$url');

    if (response.statusCode != 200) {
      throw PostException();
    }
    try {
      List<Post> body = new List();
      ApiResponseList<Post> apiResponse = new ApiResponseList();
      final postList = json.decode(response.body);
      apiResponse.status = response.statusCode;
      postList.forEach((post) {
        body.add(Post.fromJson(post));
      });
      apiResponse.body = body.reversed.toList();

      if (apiResponse.status != 200) {
        throw PostException.message(apiResponse.message);
      }

      return apiResponse.body;
    } catch (_) {
      throw PostException();
    }
  }

  Future<Post> get(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';

    final response = await GET('$url');
    if (response.statusCode != 200) {
      throw PostException();
    }
    try {
      final apiResponse =
          ApiResponseSingle<Post>.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw PostException.message(apiResponse.message);
      }
      return apiResponse.body;
    } catch (e) {
      throw PostException();
    }
  }

  Future<Post> post(Post post) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath';
    try {
      var postInJson = post.toJson();
      var bodyData = json.encode(postInJson);

      final response = await POST('$url',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData);
      if (response.statusCode != 200) {
        throw PostException();
      }

      final apiResponse =
          ApiResponseSingle.fromJson(json.decode(response.body));
      if (apiResponse.status != 200) {
        throw PostException.message(apiResponse.message);
      }
      return apiResponse.body;
    } catch (_) {
      throw PostException();
    }
  }
}
