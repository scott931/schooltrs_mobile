import '../api/api_constants.dart';
import '../api/api_response.dart';
import '../models/student.dart';
import '../models/location.dart';
import 'http_service.dart';

class StudentService {
  static final StudentService _instance = StudentService._internal();
  factory StudentService() => _instance;
  StudentService._internal();

  final HttpService _httpService = HttpService();

  Future<ApiResponse<List<Student>>> getAllStudents({
    int? page,
    int? limit,
    String? search,
    String? schoolId,
  }) async {
    final queryParams = <String, dynamic>{};
    if (page != null) queryParams['page'] = page;
    if (limit != null) queryParams['limit'] = limit;
    if (search != null) queryParams['search'] = search;
    if (schoolId != null) queryParams['school_id'] = schoolId;

    return await _httpService.get<List<Student>>(
      ApiConstants.students,
      queryParameters: queryParams,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Student.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<ApiResponse<Student>> getStudentById(String studentId) async {
    final endpoint = ApiConstants.studentById.replaceAll('{id}', studentId);

    return await _httpService.get<Student>(
      endpoint,
      fromJson: Student.fromJson,
    );
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
    final body = {
      'name': name,
      'parent_id': parentId,
      'school_id': schoolId,
      'grade': grade,
      'section': section,
      'photo': photo,
      ...?additionalData,
    };

    return await _httpService.post<Student>(
      ApiConstants.students,
      body: body,
      fromJson: Student.fromJson,
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
    final endpoint = ApiConstants.studentById.replaceAll('{id}', studentId);
    final body = <String, dynamic>{};

    if (name != null) body['name'] = name;
    if (grade != null) body['grade'] = grade;
    if (section != null) body['section'] = section;
    if (photo != null) body['photo'] = photo;
    if (additionalData != null) body.addAll(additionalData);

    return await _httpService.put<Student>(
      endpoint,
      body: body,
      fromJson: Student.fromJson,
    );
  }

  Future<ApiResponse<void>> deleteStudent(String studentId) async {
    final endpoint = ApiConstants.studentById.replaceAll('{id}', studentId);

    return await _httpService.delete<void>(endpoint);
  }

  Future<ApiResponse<Location>> getStudentLocation(String studentId) async {
    final endpoint = ApiConstants.studentLocation.replaceAll('{id}', studentId);

    return await _httpService.get<Location>(
      endpoint,
      fromJson: Location.fromJson,
    );
  }

  Future<ApiResponse<void>> updateStudentLocation({
    required String studentId,
    required double latitude,
    required double longitude,
    String? address,
  }) async {
    final endpoint = ApiConstants.studentLocation.replaceAll('{id}', studentId);
    final body = {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };

    return await _httpService.put<void>(endpoint, body: body);
  }

  Future<ApiResponse<Map<String, dynamic>>> getStudentSchedule(
      String studentId) async {
    final endpoint = ApiConstants.studentSchedule.replaceAll('{id}', studentId);

    return await _httpService.get<Map<String, dynamic>>(endpoint);
  }

  Future<ApiResponse<List<Student>>> getStudentsByParent(
      String parentId) async {
    final endpoint = ApiConstants.parentStudents.replaceAll('{id}', parentId);

    return await _httpService.get<List<Student>>(
      endpoint,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Student.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<ApiResponse<List<Student>>> getStudentsByDriver(
      String driverId) async {
    final endpoint = ApiConstants.driverStudents.replaceAll('{id}', driverId);

    return await _httpService.get<List<Student>>(
      endpoint,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Student.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<ApiResponse<void>> uploadStudentPhoto({
    required String studentId,
    required String filePath,
  }) async {
    final endpoint = ApiConstants.studentById.replaceAll('{id}', studentId);

    return await _httpService.uploadFile<void>(
      '$endpoint/photo',
      filePath: filePath,
      fieldName: 'photo',
    );
  }

  Future<ApiResponse<List<Student>>> searchStudents({
    required String query,
    String? schoolId,
    String? grade,
    int? page,
    int? limit,
  }) async {
    final queryParams = <String, dynamic>{
      'q': query,
    };

    if (schoolId != null) queryParams['school_id'] = schoolId;
    if (grade != null) queryParams['grade'] = grade;
    if (page != null) queryParams['page'] = page;
    if (limit != null) queryParams['limit'] = limit;

    return await _httpService.get<List<Student>>(
      ApiConstants.students,
      queryParameters: queryParams,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Student.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
