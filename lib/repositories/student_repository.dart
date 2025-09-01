import '../api/api_response.dart';
import '../models/student.dart';
import '../models/location.dart';
import '../services/student_service.dart';

class StudentRepository {
  static final StudentRepository _instance = StudentRepository._internal();
  factory StudentRepository() => _instance;
  StudentRepository._internal();

  final StudentService _studentService = StudentService();

  Future<ApiResponse<List<Student>>> getAllStudents({
    int? page,
    int? limit,
    String? search,
    String? schoolId,
  }) async {
    return await _studentService.getAllStudents(
      page: page,
      limit: limit,
      search: search,
      schoolId: schoolId,
    );
  }

  Future<ApiResponse<Student>> getStudentById(String studentId) async {
    return await _studentService.getStudentById(studentId);
  }

  Future<ApiResponse<Student>> createStudent({
    required String name,
    required String parentId,
    required String schoolId,
    String? grade,
    String? section,
    String? photo,
    Map<String, dynamic>? additionalData,
  }) async {
    return await _studentService.createStudent(
      name: name,
      parentId: parentId,
      schoolId: schoolId,
      grade: grade,
      section: section,
      photo: photo,
      additionalData: additionalData,
    );
  }

  Future<ApiResponse<Student>> updateStudent({
    required String studentId,
    String? name,
    String? grade,
    String? section,
    String? photo,
    Map<String, dynamic>? additionalData,
  }) async {
    return await _studentService.updateStudent(
      studentId: studentId,
      name: name,
      grade: grade,
      section: section,
      photo: photo,
      additionalData: additionalData,
    );
  }

  Future<ApiResponse<void>> deleteStudent(String studentId) async {
    return await _studentService.deleteStudent(studentId);
  }

  Future<ApiResponse<Location>> getStudentLocation(String studentId) async {
    return await _studentService.getStudentLocation(studentId);
  }

  Future<ApiResponse<void>> updateStudentLocation({
    required String studentId,
    required double latitude,
    required double longitude,
    String? address,
  }) async {
    return await _studentService.updateStudentLocation(
      studentId: studentId,
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getStudentSchedule(
      String studentId) async {
    return await _studentService.getStudentSchedule(studentId);
  }

  Future<ApiResponse<List<Student>>> getStudentsByParent(
      String parentId) async {
    return await _studentService.getStudentsByParent(parentId);
  }

  Future<ApiResponse<List<Student>>> getStudentsByDriver(
      String driverId) async {
    return await _studentService.getStudentsByDriver(driverId);
  }

  Future<ApiResponse<void>> uploadStudentPhoto({
    required String studentId,
    required String filePath,
  }) async {
    return await _studentService.uploadStudentPhoto(
      studentId: studentId,
      filePath: filePath,
    );
  }

  Future<ApiResponse<List<Student>>> searchStudents({
    required String query,
    String? schoolId,
    String? grade,
    int? page,
    int? limit,
  }) async {
    return await _studentService.searchStudents(
      query: query,
      schoolId: schoolId,
      grade: grade,
      page: page,
      limit: limit,
    );
  }
}
