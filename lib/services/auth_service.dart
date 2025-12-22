import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_model.dart';
import '../config/api_config.dart';

class AuthService {
  static final _storage = FlutterSecureStorage();
  static UserModel? _currentUser;
  static String? get token => _currentUser?.token;
  static UserModel? get currentUser => _currentUser;
  static Future<UserModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userData = data['user'];

        _currentUser = UserModel(
          id: userData['id'],
          name: userData['name'],
          email: userData['email'],
          role: userData['role'],
          token: data['token'],
        );

        // simpan token & role
        await _storage.write(key: 'token', value: data['token']);
        await _storage.write(key: 'role', value: userData['role']);

        return _currentUser;
      }

      return null;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  
  static Future<bool> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      return response.statusCode == 200 ||
          response.statusCode == 201;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }
  static Future<void> loadUserFromStorage() async {
    final token = await _storage.read(key: 'token');
    final role = await _storage.read(key: 'role');

    if (token != null && role != null) {
      _currentUser = UserModel(
        id: 0,
        name: '',
        email: '',
        role: role,
        token: token,
      );
    }
  }
  static Future<void> logout() async {
    _currentUser = null;
    await _storage.deleteAll();
  }
}
