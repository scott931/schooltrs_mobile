import 'package:hive/hive.dart';

part 'location.g.dart';

@HiveType(typeId: 4)
enum LocationType {
  @HiveField(0)
  home,
  @HiveField(1)
  school,
  @HiveField(2)
  pickup,
  @HiveField(3)
  dropoff,
}

@HiveType(typeId: 5)
class Location extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final List<double> coordinates;

  @HiveField(4)
  final LocationType type;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.coordinates,
    required this.type,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      coordinates: List<double>.from(json['coordinates']),
      type: LocationType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => LocationType.home,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'coordinates': coordinates,
      'type': type.toString().split('.').last,
    };
  }

  Location copyWith({
    String? id,
    String? name,
    String? address,
    List<double>? coordinates,
    LocationType? type,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
