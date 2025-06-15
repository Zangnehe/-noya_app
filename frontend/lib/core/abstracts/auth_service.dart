abstract class IAuthService {
  UserType? get currentUser;
  Future<UserType> login({required String email, required String password});
  Future<UserType> createUser(
      {required String email,
      required String password,
      required String fullName,
      required String birthDate,
      required String gender});
  Future<bool> logout();
  Future<void> sendEmailVerification();
  Future<void> sendResetPassword(String email);
  Future<void> deleteUser();
}

class UserType {
  final int id;
  final String? username;
  final String email;
  final String? password;
  final String? accessToken;
  final String? refreshToken;
  final int roleId;
  final String? avatar;
  final String? fullName;
  final String? phoneNumber;
  final bool isDisabled;
  final bool isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLogin;
  final String? provider;
  final String? providerId;
  final bool isEmailVerified;

  UserType({
    required this.id,
    this.username,
    required this.email,
    this.password,
    this.accessToken,
    this.refreshToken,
    required this.roleId,
    this.avatar,
    this.fullName,
    this.phoneNumber,
    required this.isDisabled,
    required this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
    this.provider,
    this.providerId,
    required this.isEmailVerified,
  });
}
