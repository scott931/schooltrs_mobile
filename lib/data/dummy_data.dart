import '../models/user.dart';
import '../models/student.dart';
import '../models/location.dart';

final List<User> dummyUsers = [
  User(
      id: '1',
      name: 'Sarah Johnson',
      email: 'sarah.johnson@email.com',
      role: UserRole.parent,
      phone: '+254712345678',
      profileImage: null),
  User(
      id: '2',
      name: 'Michael Ochieng',
      email: 'michael.driver@school.com',
      role: UserRole.driver,
      phone: '+254798765432',
      profileImage: null)
];

final List<Student> dummyStudents = [
  Student(
      id: '1',
      name: 'Emma Johnson',
      grade: 'Grade 5',
      school: 'Riverside Elementary',
      parentId: '1',
      profileImage: null,
      specialNeeds: [],
      emergencyContacts: [
        EmergencyContact(
            name: 'Sarah Johnson',
            relationship: 'Mother',
            phone: '+254712345678'),
        EmergencyContact(
            name: 'David Johnson',
            relationship: 'Father',
            phone: '+254723456789')
      ],
      pickupLocation: Location(
          id: '1',
          name: 'Home',
          address: '123 Oak Street, Westlands',
          coordinates: [-1.2691, 36.8065],
          type: LocationType.pickup),
      dropoffLocation: Location(
          id: '2',
          name: 'Riverside Elementary',
          address: '456 School Road, Karen',
          coordinates: [-1.3197, 36.7087],
          type: LocationType.school),
      busRoute: 'Route A'),
  Student(
      id: '2',
      name: 'James Johnson',
      grade: 'Grade 8',
      school: 'Westlands High School',
      parentId: '1',
      profileImage: null,
      specialNeeds: ['Requires inhaler'],
      emergencyContacts: [
        EmergencyContact(
            name: 'Sarah Johnson',
            relationship: 'Mother',
            phone: '+254712345678'),
        EmergencyContact(
            name: 'David Johnson',
            relationship: 'Father',
            phone: '+254723456789')
      ],
      pickupLocation: Location(
          id: '1',
          name: 'Home',
          address: '123 Oak Street, Westlands',
          coordinates: [-1.2691, 36.8065],
          type: LocationType.pickup),
      dropoffLocation: Location(
          id: '3',
          name: 'Westlands High School',
          address: '789 Education Ave, Westlands',
          coordinates: [-1.2633, 36.8073],
          type: LocationType.school),
      busRoute: 'Route B')
];
