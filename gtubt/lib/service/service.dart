import 'dart:io' show Platform;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kiwi/kiwi.dart';

abstract class BaseService {
  final String baseUrl = getBaseUrl();
  final String endpointPrefix = kDebugMode ? 'api/v1' : 'gtubt-api';
  Map<String, String> baseHeader = {"accept": "application/json"};

  static String getBaseUrl() {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:3000';
      }
      if (Platform.isIOS) {
        return 'http://localhost:3000';
      }
    }
    return 'https://us-central1-gtubtmobile-bb186.cloudfunctions.net';
  }

  Future<Map> _tokenResolver() async {
    KiwiContainer container = KiwiContainer();
    try {
      auth.User user = container.resolve<auth.User>();
      baseHeader = {"X-FIREBASE-TOKEN": await user.getIdToken()};
    } catch (error) {
      baseHeader.clear();
    }
    return baseHeader;
  }

  Future<http.Response> GET(url, {Map<String, String> headers}) async {
    headers ??= {};
    headers.addAll(await _tokenResolver());
    return await http.get(url, headers: headers);
  }

  Future<http.Response> POST(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    headers ??= {};
    headers.addAll(await _tokenResolver());
    return await http.post(url,
        headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> PATCH(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    headers ??= {};
    headers.addAll(await _tokenResolver());
    return await http.patch(url,
        headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> DELETE(url, {Map<String, String> headers}) async {
    headers ??= {};
    headers.addAll(await _tokenResolver());
    return await http.delete(url, headers: headers);
  }
}
