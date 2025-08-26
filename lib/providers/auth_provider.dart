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

      // Accept any email/password combination for demo purposes
      final demoUser = dummyUsers.firstWhere(
        (u) => u.role == role,
        orElse: () => User(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: email.split('@')[0] ?? 'Demo User',
            email: email,
            role: role,
            phone: '+254712345678',
            profileImage: role == UserRole.parent
                ? 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=400'
                : 'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=400'),
      );

      _user = demoUser;

      // Save to local storage
      final box = Hive.box(_authBox);
      await box.put(_userKey, demoUser.toJson());

      _isLoading = false;
      notifyListeners();

      return {'success': true};
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
