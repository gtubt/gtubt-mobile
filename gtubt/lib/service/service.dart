import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:kiwi/kiwi.dart';

abstract class BaseService {
  final String baseUrl =
      'https://us-central1-gtubtmobile-bb186.cloudfunctions.net';
  final String endpointPrefix = 'gtubt-api';
  Map<String, String> baseHeader = {};

  void _tokenResolver() async {
    KiwiContainer container = KiwiContainer();
    try {
      auth.User user = container.resolve();
<<<<<<< HEAD
      baseHeader = {"X-FIREBASE-HEADER": await user.getIdToken()};
=======
      baseHeader = {"authHeader": await user.getIdToken()};
>>>>>>> cdca3f7d3b59f4c0cf5128930608a213d20894c1
    } catch (_) {
      baseHeader.clear();
    }
  }

  Future<http.Response> GET(url, {Map<String, String> headers}) async {
    headers ??= {};
    _tokenResolver();
    headers.addAll(baseHeader);
    return await http.get(url, headers: headers);
  }

  Future<http.Response> POST(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    headers ??= {};
    _tokenResolver();
    headers.addAll(baseHeader);
    return await http.post(url,
        headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> PATCH(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    headers ??= {};
    _tokenResolver();
    headers.addAll(baseHeader);
    return await http.patch(url,
        headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> DELETE(url, {Map<String, String> headers}) async {
    headers ??= {};
    _tokenResolver();
    headers.addAll(baseHeader);
    return await http.delete(url, headers: headers);
  }
} 
