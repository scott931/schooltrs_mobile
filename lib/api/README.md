# API Integration Documentation

This folder contains a complete API integration layer for the School Transit Mobile app. The structure is designed to be modular, maintainable, and easy to use without affecting the existing UI and user flow.

## Folder Structure

```
lib/
├── api/
│   ├── api_constants.dart      # API endpoints and configuration
│   ├── api_response.dart       # Response models and error handling
│   └── README.md              # This documentation
├── services/
│   ├── http_service.dart      # Core HTTP client with authentication
│   ├── auth_service.dart      # Authentication operations
│   ├── student_service.dart   # Student-related API calls
│   ├── location_service.dart  # Location tracking and geofencing
│   ├── notification_service.dart # Push notifications
│   └── service_manager.dart   # Service initialization and management
└── repositories/
    ├── auth_repository.dart   # Authentication repository
    └── student_repository.dart # Student repository
```

## Architecture Overview

The API integration follows a layered architecture:

1. **API Layer** (`lib/api/`): Contains constants, response models, and error handling
2. **Services Layer** (`lib/services/`): Contains the actual API service classes
3. **Repository Layer** (`lib/repositories/`): Abstracts the services and provides clean interfaces
4. **Provider Layer** (`lib/providers/`): Integrates with Flutter's state management

## Quick Start

### 1. Initialize Services

In your `main.dart` or app initialization:

```dart
import 'package:your_app/providers/api_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize API services
  final apiProvider = ApiProvider();
  await apiProvider.initializeServices(
    baseUrl: 'https://your-api-url.com',
    authToken: 'optional-initial-token',
  );

  runApp(MyApp());
}
```

### 2. Use in Your Existing Providers

Replace your existing auth provider calls with API calls:

```dart
// Before (using dummy data)
final user = dummyUsers.first;

// After (using API)
final success = await apiProvider.login(
  email: 'user@example.com',
  password: 'password',
);

if (success) {
  final user = apiProvider.currentUser;
  // Navigate to home screen
}
```

### 3. Load Students

```dart
// Load all students
await apiProvider.loadStudents();

// Load students with filters
await apiProvider.loadStudents(
  search: 'John',
  schoolId: 'school123',
  page: 1,
  limit: 20,
);

// Access students
final students = apiProvider.students;
```

## API Services

### Authentication Service

Handles login, registration, and token management:

```dart
final authService = AuthService();

// Login
final response = await authService.login(
  email: 'user@example.com',
  password: 'password',
);

// Register
final response = await authService.register(
  name: 'John Doe',
  email: 'john@example.com',
  password: 'password',
  passwordConfirmation: 'password',
  userType: 'parent',
);
```

### Student Service

Manages student-related operations:

```dart
final studentService = StudentService();

// Get all students
final response = await studentService.getAllStudents();

// Create a student
final response = await studentService.createStudent(
  name: 'Jane Doe',
  parentId: 'parent123',
  schoolId: 'school123',
  grade: '5th',
  section: 'A',
);
```

### Location Service

Handles location tracking and geofencing:

```dart
final locationService = LocationService();

// Update location
await locationService.updateLocation(
  userId: 'user123',
  userType: 'driver',
  latitude: 37.7749,
  longitude: -122.4194,
  address: 'San Francisco, CA',
);

// Get nearby locations
final response = await locationService.getNearbyLocations(
  latitude: 37.7749,
  longitude: -122.4194,
  radius: 1000, // meters
);
```

### Notification Service

Manages push notifications:

```dart
final notificationService = NotificationService();

// Get notifications
final response = await notificationService.getNotifications(
  userId: 'user123',
  isRead: false,
);

// Mark as read
await notificationService.markAsRead('notification123');
```

## Error Handling

All API responses are wrapped in `ApiResponse<T>` which includes:

- `success`: Boolean indicating if the request was successful
- `data`: The actual response data
- `message`: Success or error message
- `statusCode`: HTTP status code
- `errors`: Validation errors (if any)

Example error handling:

```dart
final response = await authService.login(
  email: 'user@example.com',
  password: 'password',
);

if (response.success) {
  // Handle success
  final user = response.data;
} else {
  // Handle error
  print('Error: ${response.message}');
  if (response.errors != null) {
    // Handle validation errors
    print('Validation errors: ${response.errors}');
  }
}
```

## Configuration

### API Constants

Update `lib/api/api_constants.dart` with your actual API endpoints:

```dart
class ApiConstants {
  static const String baseUrl = 'https://your-api-url.com';
  static const String devBaseUrl = 'https://dev-api.your-domain.com';
  static const String stagingBaseUrl = 'https://staging-api.your-domain.com';

  // Update endpoints as needed
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  // ... more endpoints
}
```

### Environment Configuration

You can switch between different environments:

```dart
// Development
await apiProvider.initializeServices(
  baseUrl: ApiConstants.devBaseUrl,
);

// Production
await apiProvider.initializeServices(
  baseUrl: ApiConstants.baseUrl,
);
```

## Integration with Existing Code

The API integration is designed to work alongside your existing code:

1. **No Breaking Changes**: Your existing UI and user flow remain unchanged
2. **Gradual Migration**: You can migrate one feature at a time
3. **Fallback Support**: Keep using dummy data while testing API integration

### Example: Gradual Migration

```dart
class StudentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, apiProvider, child) {
        // Use API data if available, fallback to dummy data
        final students = apiProvider.students.isNotEmpty
            ? apiProvider.students
            : dummyStudents;

        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            return StudentCard(student: students[index]);
          },
        );
      },
    );
  }
}
```

## Testing

The API integration includes comprehensive error handling and can be easily tested:

```dart
// Test API calls
final success = await apiProvider.login(
  email: 'test@example.com',
  password: 'password',
);

if (success) {
  print('Login successful: ${apiProvider.currentUser?.name}');
} else {
  print('Login failed: ${apiProvider.errorMessage}');
}
```

## Best Practices

1. **Always check response.success** before accessing data
2. **Handle loading states** using the provided loading flags
3. **Clear errors** when starting new operations
4. **Use repositories** instead of services directly in UI code
5. **Initialize services** early in the app lifecycle
6. **Dispose services** when the app is closed

## Troubleshooting

### Common Issues

1. **Network errors**: Check internet connectivity and API URL
2. **Authentication errors**: Verify token format and expiration
3. **CORS issues**: Ensure API server allows mobile app requests
4. **Timeout errors**: Adjust timeout values in `ApiConstants`

### Debug Mode

Enable debug logging by setting the base URL to your development server and checking the console for detailed error messages.

## Support

For questions or issues with the API integration, refer to:
- API documentation for endpoint details
- Flutter HTTP package documentation
- Your backend team for API-specific questions
