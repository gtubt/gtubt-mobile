import 'dart:convert';
import 'dart:io' show Platform;

import 'package:GTUBT/exceptions/service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseService {
  final String baseUrl = getBaseUrl();
  final String endpointPrefix = 'api/v1';
  final String servicePath = '';
  String token = '';

  static String getBaseUrl() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    } else if (Platform.isIOS) {
      return 'http://localhost:8000';
    } else {
      throw UnsupportedPlatformException();
    }
  }


  String getUrl({String extraServicePath = ''}) {
    String url = '$baseUrl/$endpointPrefix/$servicePath/';
    if (extraServicePath != '') {
      url = url + '$extraServicePath/';
    }
    return url;
  }

  Future<Map<String, String>> getHeaders() async {
    Map<String, String> defaultHeader = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String token = prefs.getString("token")!;

      if (token != '') {
        defaultHeader.addAll({"Authorization": "Token $token"});
      }
    } catch (_) {}

    return defaultHeader;
  }

  Future<http.Response> GET(url) async {
    return await http.get(Uri.parse(url), headers: await getHeaders());
  }

  Future<http.Response> POST(url, {body, Encoding? encoding}) async {
    return await http.post(Uri.parse(url),
        headers: await getHeaders(), body: body, encoding: encoding);
  }

  Future<http.Response> PATCH(url, {body, Encoding? encoding}) async {
    return await http.patch(Uri.parse(url),
        headers: await getHeaders(), body: body, encoding: encoding);
  }

  Future<http.Response> DELETE(url) async {
    return await http.delete(Uri.parse(url), headers: await getHeaders());
  }
}
