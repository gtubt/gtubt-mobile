import 'dart:io' show Platform;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class BaseService {
  final String baseUrl = getBaseUrl();
  final String endpointPrefix = kDebugMode ? 'api/v1' : 'gtubt-api';

  static String getBaseUrl() {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:3000';
      }
      if (Platform.isIOS) {
        return 'http://localhost:8000';
      }
    }
    return 'https://us-central1-gtubtmobile-bb186.cloudfunctions.net';
  }

  Future<http.Response> GET(
    url, {
    Map<String, String>? headers = const {},
  }) async {
    return await http.get(Uri.parse(url), headers: headers);
  }

  Future<http.Response> POST(url,
      {
    Map<String, String>? headers = const {},
    body,
    Encoding? encoding,
  }) async {
    headers!.addAll(
      {'Content-Type': 'application/json; charset=UTF-8'},
    );
    return await http.post(Uri.parse(url),
        headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> PATCH(url,
      {
    Map<String, String>? headers = const {},
    body,
    Encoding? encoding,
  }) async {
    headers!.addAll(
      {'Content-Type': 'application/json; charset=UTF-8'},
    );
    return await http.patch(Uri.parse(url),
        headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> DELETE(
    url, {
    Map<String, String>? headers = const {},
  }) async {
    return await http.delete(Uri.parse(url), headers: headers);
  }
}
