import '../api/api_constants.dart';
import '../api/api_response.dart';
import 'http_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final HttpService _httpService = HttpService();

  Future<ApiResponse<List<Map<String, dynamic>>>> getNotifications({
    String? userId,
    String? userType,
    bool? isRead,
    int? page,
    int? limit,
  }) async {
    final queryParams = <String, dynamic>{};
    if (userId != null) queryParams['user_id'] = userId;
    if (userType != null) queryParams['user_type'] = userType;
    if (isRead != null) queryParams['is_read'] = isRead;
    if (page != null) queryParams['page'] = page;
    if (limit != null) queryParams['limit'] = limit;

    return await _httpService.get<List<Map<String, dynamic>>>(
      ApiConstants.notifications,
      queryParameters: queryParams,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getNotificationById(
      String notificationId) async {
    final endpoint =
        ApiConstants.notificationById.replaceAll('{id}', notificationId);

    return await _httpService.get<Map<String, dynamic>>(endpoint);
  }

  Future<ApiResponse<void>> markAsRead(String notificationId) async {
    final endpoint = ApiConstants.markAsRead.replaceAll('{id}', notificationId);

    return await _httpService.patch<void>(endpoint);
  }

  Future<ApiResponse<void>> markAllAsRead({
    String? userId,
    String? userType,
  }) async {
    final queryParams = <String, dynamic>{};
    if (userId != null) queryParams['user_id'] = userId;
    if (userType != null) queryParams['user_type'] = userType;

    return await _httpService.patch<void>(
      ApiConstants.markAllAsRead,
      queryParameters: queryParams,
    );
  }

  Future<ApiResponse<void>> deleteNotification(String notificationId) async {
    final endpoint =
        ApiConstants.notificationById.replaceAll('{id}', notificationId);

    return await _httpService.delete<void>(endpoint);
  }

  Future<ApiResponse<void>> sendNotification({
    required String title,
    required String message,
    required List<String> recipientIds,
    String? recipientType, // 'parent', 'driver', 'student'
    String? notificationType, // 'info', 'warning', 'error', 'success'
    Map<String, dynamic>? data,
    String? imageUrl,
  }) async {
    final body = {
      'title': title,
      'message': message,
      'recipient_ids': recipientIds,
      'recipient_type': recipientType,
      'notification_type': notificationType,
      'data': data,
      'image_url': imageUrl,
    };

    return await _httpService.post<void>(
      '/notifications/send',
      body: body,
    );
  }

  Future<ApiResponse<void>> registerDeviceToken({
    required String userId,
    required String deviceToken,
    String? platform, // 'android', 'ios'
    String? appVersion,
  }) async {
    final body = {
      'user_id': userId,
      'device_token': deviceToken,
      'platform': platform,
      'app_version': appVersion,
    };

    return await _httpService.post<void>(
      '/notifications/register-device',
      body: body,
    );
  }

  Future<ApiResponse<void>> unregisterDeviceToken({
    required String userId,
    required String deviceToken,
  }) async {
    final body = {
      'user_id': userId,
      'device_token': deviceToken,
    };

    return await _httpService.post<void>(
      '/notifications/unregister-device',
      body: body,
    );
  }

  Future<ApiResponse<void>> updateNotificationSettings({
    required String userId,
    bool? pushEnabled,
    bool? emailEnabled,
    bool? smsEnabled,
    Map<String, bool>? notificationTypes,
  }) async {
    final body = <String, dynamic>{
      'user_id': userId,
    };

    if (pushEnabled != null) body['push_enabled'] = pushEnabled;
    if (emailEnabled != null) body['email_enabled'] = emailEnabled;
    if (smsEnabled != null) body['sms_enabled'] = smsEnabled;
    if (notificationTypes != null)
      body['notification_types'] = notificationTypes;

    return await _httpService.put<void>(
      '/notifications/settings',
      body: body,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getNotificationSettings(
      String userId) async {
    return await _httpService.get<Map<String, dynamic>>(
      '/notifications/settings',
      queryParameters: {'user_id': userId},
    );
  }

  Future<ApiResponse<void>> sendEmergencyNotification({
    required String title,
    required String message,
    required String location,
    required List<String> recipientIds,
    String? emergencyType, // 'accident', 'breakdown', 'medical', 'other'
    Map<String, dynamic>? additionalData,
  }) async {
    final body = {
      'title': title,
      'message': message,
      'location': location,
      'recipient_ids': recipientIds,
      'emergency_type': emergencyType,
      'additional_data': additionalData,
    };

    return await _httpService.post<void>(
      '/notifications/emergency',
      body: body,
    );
  }

  Future<ApiResponse<List<Map<String, dynamic>>>> getNotificationHistory({
    String? userId,
    String? userType,
    DateTime? startDate,
    DateTime? endDate,
    int? page,
    int? limit,
  }) async {
    final queryParams = <String, dynamic>{};
    if (userId != null) queryParams['user_id'] = userId;
    if (userType != null) queryParams['user_type'] = userType;
    if (startDate != null)
      queryParams['start_date'] = startDate.toIso8601String();
    if (endDate != null) queryParams['end_date'] = endDate.toIso8601String();
    if (page != null) queryParams['page'] = page;
    if (limit != null) queryParams['limit'] = limit;

    return await _httpService.get<List<Map<String, dynamic>>>(
      '/notifications/history',
      queryParameters: queryParams,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
    );
  }

  Future<ApiResponse<void>> subscribeToTopic({
    required String userId,
    required String topic,
  }) async {
    final body = {
      'user_id': userId,
      'topic': topic,
    };

    return await _httpService.post<void>(
      '/notifications/subscribe',
      body: body,
    );
  }

  Future<ApiResponse<void>> unsubscribeFromTopic({
    required String userId,
    required String topic,
  }) async {
    final body = {
      'user_id': userId,
      'topic': topic,
    };

    return await _httpService.post<void>(
      '/notifications/unsubscribe',
      body: body,
    );
  }
}
