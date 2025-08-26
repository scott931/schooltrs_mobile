import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart';
import '../data/dummy_data.dart';

class AuthProvider extends ChangeNotifier {
  static const String _userKey = 'current_user';
  static const String _authBox = 'auth_box';

  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  static Future<void> initialize() async {
    await Hive.openBox(_authBox);
  }

  Future<void> loadUser() async {
    final box = Hive.box(_authBox);
    final userData = box.get(_userKey);
    if (userData != null) {
      _user = User.fromJson(Map<String, dynamic>.from(userData));
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> signIn(
      String email, String password, UserRole role) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Demo credentials for testing
      final demoCredentials = {
        UserRole.parent: {
          'email': 'sarah.johnson@email.com',
          'password': 'parent123',
          'userId': '1', // This matches the parent ID in dummy data
        },
        UserRole.driver: {
          'email': 'michael.driver@school.com',
          'password': 'driver123',
          'userId': '2',
        },
      };

      final credentials = demoCredentials[role];

      if (credentials != null &&
          email == credentials['email'] &&
          password == credentials['password']) {
        // Find the user in dummy data
        final user = dummyUsers.firstWhere(
          (u) => u.id == credentials['userId'],
          orElse: () => User(
            id: credentials['userId']!,
            name: email.split('@')[0] ?? 'Demo User',
            email: email,
            role: role,
            phone: '+254712345678',
            profileImage: null,
          ),
        );

        _user = user;

        // Debug information
        print('User authenticated: ${user.name} (ID: ${user.id})');
        print('User role: ${user.role}');

        // Save to local storage
        final box = Hive.box(_authBox);
        await box.put(_userKey, user.toJson());

        _isLoading = false;
        notifyListeners();

        return {'success': true};
      } else {
        _isLoading = false;
        notifyListeners();
        return {'success': false, 'error': 'Invalid email or password'};
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'error': 'Login failed'};
    }
  }

  Future<Map<String, dynamic>> signUp(Map<String, dynamic> userData) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: userData['name'] ?? '',
        email: userData['email'] ?? '',
        role: userData['role'] ?? UserRole.parent,
        phone: userData['phone'],
        profileImage: userData['profileImage'],
      );

      _user = newUser;

      // Save to local storage
      final box = Hive.box(_authBox);
      await box.put(_userKey, newUser.toJson());

      _isLoading = false;
      notifyListeners();

      return {'success': true};
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'error': 'Sign up failed'};
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _user = null;

    // Clear from local storage
    final box = Hive.box(_authBox);
    await box.delete(_userKey);

    _isLoading = false;
    notifyListeners();
  }
}
