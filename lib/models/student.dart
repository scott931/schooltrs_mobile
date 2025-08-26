import 'package:hive/hive.dart';
import 'location.dart';

part 'student.g.dart';

@HiveType(typeId: 2)
class EmergencyContact extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String relationship;

  @HiveField(2)
  final String phone;

  EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phone,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'] as String,
      relationship: json['relationship'] as String,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relationship': relationship,
      'phone': phone,
    };
  }
}

@HiveType(typeId: 3)
class Student extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String grade;

  @HiveField(3)
  final String school;

  @HiveField(4)
  final String parentId;

  @HiveField(5)
  final String? profileImage;

  @HiveField(6)
  final List<String> specialNeeds;

  @HiveField(7)
  final List<EmergencyContact> emergencyContacts;

  @HiveField(8)
  final Location pickupLocation;

  @HiveField(9)
  final Location dropoffLocation;

  @HiveField(10)
  final String busRoute;

  Student({
    required this.id,
    required this.name,
    required this.grade,
    required this.school,
    required this.parentId,
    this.profileImage,
    required this.specialNeeds,
    required this.emergencyContacts,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.busRoute,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      name: json['name'] as String,
      grade: json['grade'] as String,
      school: json['school'] as String,
      parentId: json['parentId'] as String,
      profileImage: json['profileImage'] as String?,
      specialNeeds: List<String>.from(json['specialNeeds'] ?? []),
      emergencyContacts: (json['emergencyContacts'] as List)
          .map((e) => EmergencyContact.fromJson(e))
          .toList(),
      pickupLocation: Location.fromJson(json['pickupLocation']),
      dropoffLocation: Location.fromJson(json['dropoffLocation']),
      busRoute: json['busRoute'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'grade': grade,
      'school': school,
      'parentId': parentId,
      'profileImage': profileImage,
      'specialNeeds': specialNeeds,
      'emergencyContacts': emergencyContacts.map((e) => e.toJson()).toList(),
      'pickupLocation': pickupLocation.toJson(),
      'dropoffLocation': dropoffLocation.toJson(),
      'busRoute': busRoute,
    };
  }

  Student copyWith({
    String? id,
    String? name,
    String? grade,
    String? school,
    String? parentId,
    String? profileImage,
    List<String>? specialNeeds,
    List<EmergencyContact>? emergencyContacts,
    Location? pickupLocation,
    Location? dropoffLocation,
    String? busRoute,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      grade: grade ?? this.grade,
      school: school ?? this.school,
      parentId: parentId ?? this.parentId,
      profileImage: profileImage ?? this.profileImage,
      specialNeeds: specialNeeds ?? this.specialNeeds,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      busRoute: busRoute ?? this.busRoute,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Student && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
