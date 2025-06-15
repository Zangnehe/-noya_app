import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/core/abstracts/auth_service.dart';
import 'package:frontend/core/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthService implements IAuthService {
  UserType? _currentUser;

  @override
  UserType? get currentUser => _currentUser;

  set currentUser(UserType? user) {
    _currentUser = user;
  }

  @override
  Future<UserType> createUser(
      {required String email,
      required String password,
      required String fullName,
      required String birthDate,
      required String gender}) async {
    try {
      // Tạo user mới với email và password
      final response = await http.post(
        Uri.parse('${backendUrl}/api/v1/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'fullName': fullName,
          'birthDate': birthDate,
          'gender': gender,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        this.currentUser = UserType(
          id: data['id'],
          email: data['email'],
          roleId: data['role_id'],
          accessToken: data['access_token'],
          isDisabled: data['is_disabled'] ?? false,
          isDeleted: data['is_deleted'] ?? false,
          createdAt: DateTime.parse(data['created_at']),
          updatedAt: DateTime.parse(data['updated_at']),
          isEmailVerified: data['is_email_verified'] ?? false,
          username: data['username'],
          avatar: data['avatar'],
          fullName: data['full_name'],
          phoneNumber: data['phone_number'],
          provider: data['provider'],
          providerId: data['provider_id'],
          lastLogin: data['last_login'] != null
              ? DateTime.parse(data['last_login'])
              : null,
        );
        return this.currentUser!;
      } else {
        throw Exception('Không thể tạo người dùng mới');
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> deleteUser() {
    throw UnimplementedError();
  }

  @override
  Future<UserType> login(
      {required String email, required String password}) async {
    try {
      // Tạo user mới với email và password
      final response = await http.post(
        Uri.parse('${backendUrl}/api/v1/auth/local/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        this.currentUser = UserType(
          id: data['id'],
          email: data['email'],
          roleId: data['role_id'],
          accessToken: data['access_token'],
          isDisabled: data['is_disabled'] ?? false,
          isDeleted: data['is_deleted'] ?? false,
          createdAt: DateTime.parse(data['created_at']),
          updatedAt: DateTime.parse(data['updated_at']),
          isEmailVerified: data['is_email_verified'] ?? false,
          username: data['username'],
          avatar: data['avatar'],
          fullName: data['full_name'],
          phoneNumber: data['phone_number'],
          provider: data['provider'],
          providerId: data['provider_id'],
          lastLogin: data['last_login'] != null
              ? DateTime.parse(data['last_login'])
              : null,
        );
        return this.currentUser!;
      } else {
        throw Exception('Không thể tạo người dùng mới');
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final response = await http.post(
        Uri.parse('${backendUrl}/api/v1/auth/logout'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer ${this.currentUser!.accessToken}',
          'userId': this.currentUser!.id.toString(),
        },
      );
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('access_token');
        this.currentUser = null;
        return true;
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> sendEmailVerification() {
    throw UnimplementedError();
  }

  @override
  Future<void> sendResetPassword(String email) {
    throw UnimplementedError();
  }
}
