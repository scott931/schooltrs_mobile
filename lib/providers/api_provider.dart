import 'package:flutter/foundation.dart';
import '../api/api_response.dart';
import '../models/user.dart';
import '../models/student.dart';
import '../repositories/auth_repository.dart';
import '../repositories/student_repository.dart';
import '../services/service_manager.dart';

class ApiProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final StudentRepository _studentRepository = StudentRepository();
  final ServiceManager _serviceManager = ServiceManager();

  // Loading states
  bool _isLoading = false;
  bool _isAuthenticating = false;
  bool _isLoadingStudents = false;

  // Data
  User? _currentUser;
  List<Student> _students = [];
  String? _errorMessage;

  // Getters
  bool get isLoading => _isLoading;
  bool get isAuthenticating => _isAuthenticating;
  bool get isLoadingStudents => _isLoadingStudents;
  User? get currentUser => _currentUser;
  List<Student> get students => _students;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _authRepository.isAuthenticated;

  // Initialize the API services
  Future<void> initializeServices({
    String? baseUrl,
    String? authToken,
  }) async {
    try {
      await _serviceManager.initialize(
        baseUrl: baseUrl,
        authToken: authToken,
      );
      _clearError();
    } catch (e) {
      _setError('Failed to initialize services: ${e.toString()}');
    }
  }

  // Authentication methods
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setAuthenticating(true);
    _clearError();

    try {
      final response = await _authRepository.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        _currentUser = response.data!;
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Login failed');
        return false;
      }
    } catch (e) {
      _setError('Login error: ${e.toString()}');
      return false;
    } finally {
      _setAuthenticating(false);
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String userType,
    Map<String, dynamic>? additionalData,
  }) async {
    _setAuthenticating(true);
    _clearError();

    try {
      final response = await _authRepository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        userType: userType,
        additionalData: additionalData,
      );

      if (response.success && response.data != null) {
        _currentUser = response.data!;
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Registration failed');
        return false;
      }
    } catch (e) {
      _setError('Registration error: ${e.toString()}');
      return false;
    } finally {
      _setAuthenticating(false);
    }
  }

  Future<bool> logout() async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _authRepository.logout();

      if (response.success) {
        _currentUser = null;
        _students.clear();
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Logout failed');
        return false;
      }
    } catch (e) {
      _setError('Logout error: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> getProfile() async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _authRepository.getProfile();

      if (response.success && response.data != null) {
        _currentUser = response.data!;
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Failed to get profile');
        return false;
      }
    } catch (e) {
      _setError('Profile error: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Student methods
  Future<bool> loadStudents({
    int? page,
    int? limit,
    String? search,
    String? schoolId,
  }) async {
    _setLoadingStudents(true);
    _clearError();

    try {
      final response = await _studentRepository.getAllStudents(
        page: page,
        limit: limit,
        search: search,
        schoolId: schoolId,
      );

      if (response.success && response.data != null) {
        _students = response.data!;
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Failed to load students');
        return false;
      }
    } catch (e) {
      _setError('Students error: ${e.toString()}');
      return false;
    } finally {
      _setLoadingStudents(false);
    }
  }

  Future<bool> loadStudentsByParent(String parentId) async {
    _setLoadingStudents(true);
    _clearError();

    try {
      final response = await _studentRepository.getStudentsByParent(parentId);

      if (response.success && response.data != null) {
        _students = response.data!;
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Failed to load students');
        return false;
      }
    } catch (e) {
      _setError('Students error: ${e.toString()}');
      return false;
    } finally {
      _setLoadingStudents(false);
    }
  }

  Future<bool> createStudent({
    required String name,
    required String parentId,
    required String schoolId,
    String? grade,
    String? section,
    String? photo,
    Map<String, dynamic>? additionalData,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _studentRepository.createStudent(
        name: name,
        parentId: parentId,
        schoolId: schoolId,
        grade: grade,
        section: section,
        photo: photo,
        additionalData: additionalData,
      );

      if (response.success && response.data != null) {
        // Refresh the students list
        await loadStudents();
        return true;
      } else {
        _setError(response.message ?? 'Failed to create student');
        return false;
      }
    } catch (e) {
      _setError('Create student error: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateStudent({
    required String studentId,
    String? name,
    String? grade,
    String? section,
    String? photo,
    Map<String, dynamic>? additionalData,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _studentRepository.updateStudent(
        studentId: studentId,
        name: name,
        grade: grade,
        section: section,
        photo: photo,
        additionalData: additionalData,
      );

      if (response.success && response.data != null) {
        // Update the student in the list
        final index = _students.indexWhere((s) => s.id == studentId);
        if (index != -1) {
          _students[index] = response.data!;
          notifyListeners();
        }
        return true;
      } else {
        _setError(response.message ?? 'Failed to update student');
        return false;
      }
    } catch (e) {
      _setError('Update student error: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setAuthenticating(bool authenticating) {
    _isAuthenticating = authenticating;
    notifyListeners();
  }

  void _setLoadingStudents(bool loading) {
    _isLoadingStudents = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }

  @override
  void dispose() {
    _serviceManager.dispose();
    super.dispose();
  }
}
