import '../api/api_constants.dart';
import '../api/api_response.dart';
import '../models/location.dart';
import 'http_service.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final HttpService _httpService = HttpService();

  Future<ApiResponse<void>> updateLocation({
    required String userId,
    required String userType, // 'driver', 'student'
    required double latitude,
    required double longitude,
    String? address,
    double? accuracy,
    double? speed,
    double? heading,
    DateTime? timestamp,
  }) async {
    final body = {
      'user_id': userId,
      'user_type': userType,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'accuracy': accuracy,
      'speed': speed,
      'heading': heading,
      'timestamp': timestamp?.toIso8601String(),
    };

    return await _httpService.post<void>(
      ApiConstants.updateLocation,
      body: body,
    );
  }

  Future<ApiResponse<Location>> getLocation(String locationId) async {
    final endpoint = ApiConstants.locationById.replaceAll('{id}', locationId);

    return await _httpService.get<Location>(
      endpoint,
      fromJson: Location.fromJson,
    );
  }

  Future<ApiResponse<List<Location>>> getLocationHistory({
    required String userId,
    required String userType,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    final queryParams = <String, dynamic>{
      'user_id': userId,
      'user_type': userType,
    };

    if (startDate != null)
      queryParams['start_date'] = startDate.toIso8601String();
    if (endDate != null) queryParams['end_date'] = endDate.toIso8601String();
    if (limit != null) queryParams['limit'] = limit;

    return await _httpService.get<List<Location>>(
      ApiConstants.locations,
      queryParameters: queryParams,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Location.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<ApiResponse<List<Location>>> getNearbyLocations({
    required double latitude,
    required double longitude,
    required double radius, // in meters
    String? userType,
    int? limit,
  }) async {
    final queryParams = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
    };

    if (userType != null) queryParams['user_type'] = userType;
    if (limit != null) queryParams['limit'] = limit;

    return await _httpService.get<List<Location>>(
      ApiConstants.locations,
      queryParameters: queryParams,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Location.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getRouteDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
    String? mode, // 'driving', 'walking', 'bicycling'
  }) async {
    final queryParams = <String, dynamic>{
      'start_lat': startLatitude,
      'start_lng': startLongitude,
      'end_lat': endLatitude,
      'end_lng': endLongitude,
    };

    if (mode != null) queryParams['mode'] = mode;

    return await _httpService.get<Map<String, dynamic>>(
      '/route/distance',
      queryParameters: queryParams,
    );
  }

  Future<ApiResponse<List<Map<String, dynamic>>>> getRouteDirections({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
    String? mode,
    List<Map<String, double>>? waypoints,
  }) async {
    final queryParams = <String, dynamic>{
      'start_lat': startLatitude,
      'start_lng': startLongitude,
      'end_lat': endLatitude,
      'end_lng': endLongitude,
    };

    if (mode != null) queryParams['mode'] = mode;
    if (waypoints != null) {
      queryParams['waypoints'] =
          waypoints.map((wp) => '${wp['lat']},${wp['lng']}').join('|');
    }

    return await _httpService.get<List<Map<String, dynamic>>>(
      '/route/directions',
      queryParameters: queryParams,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
    );
  }

  Future<ApiResponse<void>> startLocationTracking({
    required String userId,
    required String userType,
    int? updateInterval, // in seconds
  }) async {
    final body = {
      'user_id': userId,
      'user_type': userType,
      'update_interval': updateInterval,
    };

    return await _httpService.post<void>(
      '/location/tracking/start',
      body: body,
    );
  }

  Future<ApiResponse<void>> stopLocationTracking({
    required String userId,
    required String userType,
  }) async {
    final body = {
      'user_id': userId,
      'user_type': userType,
    };

    return await _httpService.post<void>(
      '/location/tracking/stop',
      body: body,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getGeofenceStatus({
    required String userId,
    required String userType,
    required double latitude,
    required double longitude,
  }) async {
    final queryParams = <String, dynamic>{
      'user_id': userId,
      'user_type': userType,
      'latitude': latitude,
      'longitude': longitude,
    };

    return await _httpService.get<Map<String, dynamic>>(
      '/location/geofence/status',
      queryParameters: queryParams,
    );
  }

  Future<ApiResponse<void>> createGeofence({
    required String name,
    required double latitude,
    required double longitude,
    required double radius,
    String? description,
    Map<String, dynamic>? metadata,
  }) async {
    final body = {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'description': description,
      'metadata': metadata,
    };

    return await _httpService.post<void>(
      '/location/geofence',
      body: body,
    );
  }

  Future<ApiResponse<List<Map<String, dynamic>>>> getGeofences({
    String? userId,
    String? userType,
  }) async {
    final queryParams = <String, dynamic>{};
    if (userId != null) queryParams['user_id'] = userId;
    if (userType != null) queryParams['user_type'] = userType;

    return await _httpService.get<List<Map<String, dynamic>>>(
      '/location/geofence',
      queryParameters: queryParams,
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
    );
  }
}
