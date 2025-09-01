class ApiConstants {
  // Base URLs
  static const String baseUrl =
      'https://api.schooltransit.com'; // Replace with your actual API base URL
  static const String devBaseUrl = 'https://dev-api.schooltransit.com';
  static const String stagingBaseUrl = 'https://staging-api.schooltransit.com';

  // API Version
  static const String apiVersion = '/v1';

  // Authentication endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // User endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String changePassword = '/user/change-password';

  // Student endpoints
  static const String students = '/students';
  static const String studentById = '/students/{id}';
  static const String studentLocation = '/students/{id}/location';
  static const String studentSchedule = '/students/{id}/schedule';

  // Driver endpoints
  static const String drivers = '/drivers';
  static const String driverById = '/drivers/{id}';
  static const String driverLocation = '/drivers/{id}/location';
  static const String driverRoute = '/drivers/{id}/route';
  static const String driverStudents = '/drivers/{id}/students';

  // Parent endpoints
  static const String parents = '/parents';
  static const String parentById = '/parents/{id}';
  static const String parentStudents = '/parents/{id}/students';
  static const String parentNotifications = '/parents/{id}/notifications';

  // Location endpoints
  static const String locations = '/locations';
  static const String locationById = '/locations/{id}';
  static const String updateLocation = '/locations/update';

  // Route endpoints
  static const String routes = '/routes';
  static const String routeById = '/routes/{id}';
  static const String routeStops = '/routes/{id}/stops';

  // Notification endpoints
  static const String notifications = '/notifications';
  static const String notificationById = '/notifications/{id}';
  static const String markAsRead = '/notifications/{id}/read';
  static const String markAllAsRead = '/notifications/read-all';

  // Trip endpoints
  static const String trips = '/trips';
  static const String tripById = '/trips/{id}';
  static const String tripStatus = '/trips/{id}/status';
  static const String tripLocation = '/trips/{id}/location';

  // School endpoints
  static const String schools = '/schools';
  static const String schoolById = '/schools/{id}';

  // Vehicle endpoints
  static const String vehicles = '/vehicles';
  static const String vehicleById = '/vehicles/{id}';

  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Error messages
  static const String networkError = 'Network error occurred';
  static const String serverError = 'Server error occurred';
  static const String unauthorizedError = 'Unauthorized access';
  static const String notFoundError = 'Resource not found';
  static const String validationError = 'Validation error';
}
