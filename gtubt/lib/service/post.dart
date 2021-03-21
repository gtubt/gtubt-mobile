import 'dart:io';

import 'package:GTUBT/models/api_response.dart';
import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/service/base.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostFailure {
  final String message;

  PostFailure(this.message);

  @override
  String toString() => message;
}

class PostService extends BaseService {
  static final PostService _postService = PostService._internal();
  final servicePath = 'posts';
  PostService._internal();

  factory PostService() {
    return _postService;
  }

  Future<Either<List<Post>, PostFailure>> getAll() async {
    String url = '$baseUrl/$endpointPrefix/$servicePath';

    final response = await http.get('$url');
    var apiResponse;
    if (response.statusCode == 200) {
      apiResponse = ApiResponseList<Post>.fromJson(json.decode(response.body));
      if (apiResponse.status == 200) {
        return Left(apiResponse.body);
      }
    }
    return Right(PostFailure(apiResponse.message));
  }

  Future<Either<Post, PostFailure>> get(String id) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath/$id';
    var apiResponse;
    try {
      final response = await http.get('$url');

      if (response.statusCode == 200) {
        apiResponse =
            ApiResponseSingle<Post>.fromJson(json.decode(response.body));
        if (apiResponse.status == 200) {
          return Left(apiResponse.body);
        }
      }
    } catch (e) {
      return Right(PostFailure(apiResponse.message));
    }
  }

  Future<Either<http.Response, PostFailure>> post(Post post) async {
    String url = '$baseUrl/$endpointPrefix/$servicePath';
    var postInJson = post.toJson();
    var bodyData = json.encode(postInJson);

    final response = await http.post('$url',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyData);
    if (response.statusCode == 200) {
      return Left(response);
    }
    return Right(PostFailure("Couldn't post the post 😱"));
  }
}
