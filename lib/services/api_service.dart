import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import 'auth_service.dart';

class ApiService {
  /// GET
  static Future<http.Response> get(
    String endpoint, {
    String? token,
  }) async {
    return await http.get(
      Uri.parse('${ApiConfig.baseUrl}$endpoint'),
      headers: _headers(token),
    );
  }

  /// POST
  static Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    return await http.post(
      Uri.parse('${ApiConfig.baseUrl}$endpoint'),
      headers: _headers(token),
      body: jsonEncode(body ?? {}),
    );
  }

  /// PUT
  static Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    return await http.put(
      Uri.parse('${ApiConfig.baseUrl}$endpoint'),
      headers: _headers(token),
      body: jsonEncode(body ?? {}),
    );
  }

  /// HEADER
  static Map<String, String> _headers(String? token) {
    final headers = {
      'Content-Type': 'application/json',
    };

    final authToken = token ?? AuthService.currentUser?.token;
    if (authToken != null) {
      headers['Authorization'] = 'Bearer $authToken';
    }

    return headers;
  }
}
