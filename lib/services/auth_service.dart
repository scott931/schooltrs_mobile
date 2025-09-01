import '../api/api_constants.dart';
import '../api/api_response.dart';
import '../models/user.dart';
import 'http_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final HttpService _httpService = HttpService();

  Future<ApiResponse<User>> login({
    required String email,
    required String password,
  }) async {
    final response = await _httpService.post<Map<String, dynamic>>(
      ApiConstants.login,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.success && response.data != null) {
      // Extract token from response if available
      final token = response.data!['token'] as String?;
      if (token != null) {
        _httpService.setAuthToken(token);
      }

      // Parse user data
      final userData = response.data!['user'] as Map<String, dynamic>?;
      if (userData != null) {
        final user = User.fromJson(userData);
        return ApiResponse.success(data: user, message: response.message);
      }
    }

    return ApiResponse.error(
      message: response.message ?? 'Login failed',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<User>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String userType, // 'parent', 'driver', 'admin'
    Map<String, dynamic>? additionalData,
  }) async {
    final body = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'user_type': userType,
      ...?additionalData,
    };

    final response = await _httpService.post<Map<String, dynamic>>(
      ApiConstants.register,
      body: body,
    );

    if (response.success && response.data != null) {
      // Extract token from response if available
      final token = response.data!['token'] as String?;
      if (token != null) {
        _httpService.setAuthToken(token);
      }

      // Parse user data
      final userData = response.data!['user'] as Map<String, dynamic>?;
      if (userData != null) {
        final user = User.fromJson(userData);
        return ApiResponse.success(data: user, message: response.message);
      }
    }

    return ApiResponse.error(
      message: response.message ?? 'Registration failed',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<void>> logout() async {
    final response = await _httpService.post<void>(
      ApiConstants.logout,
    );

    if (response.success) {
      _httpService.clearAuthToken();
    }

    return response;
  }

  Future<ApiResponse<User>> getProfile() async {
    return await _httpService.get<User>(
      ApiConstants.userProfile,
      fromJson: User.fromJson,
    );
  }

  Future<ApiResponse<User>> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? profileImage,
  }) async {
    final body = <String, dynamic>{};

    if (name != null) body['name'] = name;
    if (email != null) body['email'] = email;
    if (phone != null) body['phone'] = phone;
    if (profileImage != null) body['profile_image'] = profileImage;

    return await _httpService.put<User>(
      ApiConstants.updateProfile,
      body: body,
      fromJson: User.fromJson,
    );
  }

  Future<ApiResponse<void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    return await _httpService.post<void>(
      ApiConstants.changePassword,
      body: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      },
    );
  }

  Future<ApiResponse<void>> forgotPassword({
    required String email,
  }) async {
    return await _httpService.post<void>(
      ApiConstants.forgotPassword,
      body: {
        'email': email,
      },
    );
  }

  Future<ApiResponse<void>> resetPassword({
    required String token,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await _httpService.post<void>(
      ApiConstants.resetPassword,
      body: {
        'token': token,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
  }

  Future<ApiResponse<String>> refreshToken() async {
    final response = await _httpService.post<Map<String, dynamic>>(
      ApiConstants.refreshToken,
    );

    if (response.success && response.data != null) {
      final token = response.data!['token'] as String?;
      if (token != null) {
        _httpService.setAuthToken(token);
        return ApiResponse.success(data: token);
      }
    }

    return ApiResponse.error(
      message: 'Failed to refresh token',
      statusCode: response.statusCode,
    );
  }

  bool get isAuthenticated {
    // You might want to check if the token exists and is valid
    // This is a simple check - you might want to add token validation
    return true; // Replace with actual token validation logic
  }

  void setAuthToken(String token) {
    _httpService.setAuthToken(token);
  }

  void clearAuthToken() {
    _httpService.clearAuthToken();
  }
}
