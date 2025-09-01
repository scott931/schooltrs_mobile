import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../api/api_constants.dart';
import '../api/api_response.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;
  HttpService._internal();

  late http.Client _client;
  String? _authToken;
  String _baseUrl = ApiConstants.baseUrl;

  void initialize() {
    _client = http.Client();
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  String get _fullBaseUrl => '$_baseUrl${ApiConstants.apiVersion}';

  Map<String, String> get _headers {
    final headers = Map<String, String>.from(ApiConstants.defaultHeaders);
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client
          .get(uri, headers: _headers)
          .timeout(Duration(milliseconds: ApiConstants.connectionTimeout));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return _handleException<T>(e);
    }
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client
          .post(
            uri,
            headers: _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(Duration(milliseconds: ApiConstants.connectionTimeout));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return _handleException<T>(e);
    }
  }

  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client
          .put(
            uri,
            headers: _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(Duration(milliseconds: ApiConstants.connectionTimeout));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return _handleException<T>(e);
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client
          .delete(uri, headers: _headers)
          .timeout(Duration(milliseconds: ApiConstants.connectionTimeout));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return _handleException<T>(e);
    }
  }

  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client
          .patch(
            uri,
            headers: _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(Duration(milliseconds: ApiConstants.connectionTimeout));

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return _handleException<T>(e);
    }
  }

  Future<ApiResponse<T>> uploadFile<T>(
    String endpoint, {
    required String filePath,
    required String fieldName,
    Map<String, String>? additionalFields,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final file = File(filePath);

      if (!await file.exists()) {
        return ApiResponse.error(
          message: 'File not found: $filePath',
          statusCode: 400,
        );
      }

      final request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll(_headers);
      request.headers
          .remove('Content-Type'); // Let the browser set this for multipart

      // Add file
      request.files.add(
        await http.MultipartFile.fromPath(fieldName, filePath),
      );

      // Add additional fields
      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return _handleException<T>(e);
    }
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    final uri = Uri.parse('$_fullBaseUrl$endpoint');

    if (queryParameters != null) {
      final queryMap = queryParameters.map(
        (key, value) => MapEntry(key, value.toString()),
      );
      return uri.replace(queryParameters: queryMap);
    }

    return uri;
  }

  ApiResponse<T> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    try {
      final body = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (fromJson != null && body['data'] != null) {
          final data = fromJson(body['data']);
          return ApiResponse.success(
            data: data,
            message: body['message'],
            statusCode: response.statusCode,
          );
        } else if (fromJson != null) {
          final data = fromJson(body);
          return ApiResponse.success(
            data: data,
            message: body['message'],
            statusCode: response.statusCode,
          );
        } else {
          return ApiResponse.success(
            data: body as T,
            message: body['message'],
            statusCode: response.statusCode,
          );
        }
      } else {
        return ApiResponse.error(
          message: body['message'] ?? _getErrorMessage(response.statusCode),
          statusCode: response.statusCode,
          errors: body['errors'],
        );
      }
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to parse response: ${e.toString()}',
        statusCode: response.statusCode,
      );
    }
  }

  ApiResponse<T> _handleException<T>(dynamic exception) {
    if (exception is SocketException) {
      return ApiResponse.error(
        message: ApiConstants.networkError,
        statusCode: 0,
      );
    } else if (exception is HttpException) {
      return ApiResponse.error(
        message: ApiConstants.serverError,
        statusCode: 500,
      );
    } else {
      return ApiResponse.error(
        message: exception.toString(),
        statusCode: 0,
      );
    }
  }

  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return ApiConstants.validationError;
      case 401:
        return ApiConstants.unauthorizedError;
      case 404:
        return ApiConstants.notFoundError;
      case 500:
        return ApiConstants.serverError;
      default:
        return 'Error occurred with status code: $statusCode';
    }
  }

  void dispose() {
    _client.close();
  }
}
