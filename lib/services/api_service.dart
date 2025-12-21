import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  static Map<String, String> headers({String? token}) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<http.Response> get(
    String endpoint, {
    String? token,
  }) async {
    return await http.get(
      Uri.parse(ApiConfig.baseUrl + endpoint),
      headers: headers(token: token),
    );
  }

  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    return await http.post(
      Uri.parse(ApiConfig.baseUrl + endpoint),
      headers: headers(token: token),
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> put(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    return await http.put(
      Uri.parse(ApiConfig.baseUrl + endpoint),
      headers: headers(token: token),
      body: jsonEncode(body),
    );
  }
}
