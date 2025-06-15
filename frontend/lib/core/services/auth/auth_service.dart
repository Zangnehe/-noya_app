import 'package:frontend/core/abstracts/auth_service.dart';
import 'package:frontend/core/services/auth/local_auth_service.dart';

class AuthService implements IAuthService {
  final IAuthService authService;
  const AuthService(this.authService);
  factory AuthService.local() => AuthService(LocalAuthService());

  @override
  Future<UserType> createUser({
    required String email,
    required String password,
    required String fullName,
    required String birthDate,
    required String gender,
  }) =>
      authService.createUser(
          email: email,
          password: password,
          fullName: fullName,
          birthDate: birthDate,
          gender: gender);

  @override
  UserType? get currentUser => authService.currentUser;

  @override
  Future<UserType> login({
    required String email,
    required String password,
  }) =>
      authService.login(email: email, password: password);

  @override
  Future<bool> logout() => authService.logout();

  @override
  Future<void> sendEmailVerification() => authService.sendEmailVerification();

  @override
  Future<void> sendResetPassword(String email) =>
      authService.sendResetPassword(email);
  @override
  Future<void> deleteUser() => authService.deleteUser();
}
