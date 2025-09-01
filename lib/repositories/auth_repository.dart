import '../api/api_response.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  factory AuthRepository() => _instance;
  AuthRepository._internal();

  final AuthService _authService = AuthService();

  Future<ApiResponse<User>> login({
    required String email,
    required String password,
  }) async {
    return await _authService.login(
      email: email,
      password: password,
    );
  }

  Future<ApiResponse<User>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String userType,
    Map<String, dynamic>? additionalData,
  }) async {
    return await _authService.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      userType: userType,
      additionalData: additionalData,
    );
  }

  Future<ApiResponse<void>> logout() async {
    return await _authService.logout();
  }

  Future<ApiResponse<User>> getProfile() async {
    return await _authService.getProfile();
  }

  Future<ApiResponse<User>> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? profileImage,
  }) async {
    return await _authService.updateProfile(
      name: name,
      email: email,
      phone: phone,
      profileImage: profileImage,
    );
  }

  Future<ApiResponse<void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    return await _authService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
    );
  }

  Future<ApiResponse<void>> forgotPassword({
    required String email,
  }) async {
    return await _authService.forgotPassword(email: email);
  }

  Future<ApiResponse<void>> resetPassword({
    required String token,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await _authService.resetPassword(
      token: token,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }

  Future<ApiResponse<String>> refreshToken() async {
    return await _authService.refreshToken();
  }

  bool get isAuthenticated => _authService.isAuthenticated;

  void setAuthToken(String token) {
    _authService.setAuthToken(token);
  }

  void clearAuthToken() {
    _authService.clearAuthToken();
  }
}
