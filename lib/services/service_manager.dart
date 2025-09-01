import 'http_service.dart';
import 'auth_service.dart';
import 'student_service.dart';
import 'location_service.dart';
import 'notification_service.dart';

class ServiceManager {
  static final ServiceManager _instance = ServiceManager._internal();
  factory ServiceManager() => _instance;
  ServiceManager._internal();

  late HttpService _httpService;
  late AuthService _authService;
  late StudentService _studentService;
  late LocationService _locationService;
  late NotificationService _notificationService;

  bool _isInitialized = false;

  HttpService get httpService => _httpService;
  AuthService get authService => _authService;
  StudentService get studentService => _studentService;
  LocationService get locationService => _locationService;
  NotificationService get notificationService => _notificationService;

  bool get isInitialized => _isInitialized;

  Future<void> initialize({
    String? baseUrl,
    String? authToken,
  }) async {
    if (_isInitialized) return;

    // Initialize HTTP service
    _httpService = HttpService();
    _httpService.initialize();

    // Set base URL if provided
    if (baseUrl != null) {
      _httpService.setBaseUrl(baseUrl);
    }

    // Set auth token if provided
    if (authToken != null) {
      _httpService.setAuthToken(authToken);
    }

    // Initialize other services
    _authService = AuthService();
    _studentService = StudentService();
    _locationService = LocationService();
    _notificationService = NotificationService();

    _isInitialized = true;
  }

  void setAuthToken(String token) {
    if (!_isInitialized) {
      throw StateError(
          'ServiceManager must be initialized before setting auth token');
    }
    _httpService.setAuthToken(token);
  }

  void clearAuthToken() {
    if (!_isInitialized) {
      throw StateError(
          'ServiceManager must be initialized before clearing auth token');
    }
    _httpService.clearAuthToken();
  }

  void setBaseUrl(String baseUrl) {
    if (!_isInitialized) {
      throw StateError(
          'ServiceManager must be initialized before setting base URL');
    }
    _httpService.setBaseUrl(baseUrl);
  }

  void dispose() {
    if (_isInitialized) {
      _httpService.dispose();
      _isInitialized = false;
    }
  }
}
