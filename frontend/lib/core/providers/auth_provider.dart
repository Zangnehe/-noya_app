import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/abstracts/auth_service.dart';
import 'package:frontend/core/config/constants.dart';
import 'package:frontend/core/services/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService.local();
  UserType? _currentUser;

  UserType? get currentUser => _currentUser;
  Future<void> loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      if (accessToken != null) {
        final decodedToken = JWT.decode(accessToken);
        final userId = decodedToken.payload['id'] as int;
        final user = await http.get(
          Uri.parse('${backendUrl}/api/v1/auth/users/$userId'),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $accessToken',
            'userId': userId.toString(),
          },
        );
        if (user.statusCode == 200) {
          final data = jsonDecode(user.body)['data'];
          _currentUser = UserType(
              id: userId,
              roleId: data['role_id'] as int,
              email: data['email'] as String,
              isEmailVerified: data['is_email_verified'] as bool,
              isDisabled: data['is_disabled'] as bool,
              isDeleted: data['is_deleted'] as bool,
              username: data['username'] as String,
              avatar: data['avatar'] as String,
              fullName: data['full_name'] as String,
              phoneNumber: data['phone_number'] as String,
              provider: data['provider'] as String,
              providerId: data['provider_id'] as String);
        }
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Tải người dùng thất bại: $e');
    }
  }

  Future<void> fetchCurrentUser() async {
    _currentUser = _authService.currentUser;
    notifyListeners();
  }

  Future<void> register(String email, String password, String fullName,
      String birthDate, String gender) async {
    try {
      _currentUser = await _authService.createUser(
          email: email,
          password: password,
          fullName: fullName,
          birthDate: birthDate,
          gender: gender);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'access_token', _currentUser!.accessToken as String);
    } catch (e) {
      throw Exception('Đăng ký thất bại: $e');
    }
  }

  Future<void> login(String email, String password) async {
    _currentUser = await _authService.login(email: email, password: password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', _currentUser!.accessToken as String);
    notifyListeners();
  }

  Future<void> logout() async {
    final isLogout = await _authService.logout();
    if (isLogout) {
      _currentUser = null;
      notifyListeners();
    }
  }
}
