// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmergencyContactAdapter extends TypeAdapter<EmergencyContact> {
  @override
  final int typeId = 2;

  @override
  EmergencyContact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmergencyContact(
      name: fields[0] as String,
      relationship: fields[1] as String,
      phone: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmergencyContact obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.relationship)
      ..writeByte(2)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 3;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      id: fields[0] as String,
      name: fields[1] as String,
      grade: fields[2] as String,
      school: fields[3] as String,
      parentId: fields[4] as String,
      profileImage: fields[5] as String?,
      specialNeeds: (fields[6] as List).cast<String>(),
      emergencyContacts: (fields[7] as List).cast<EmergencyContact>(),
      pickupLocation: fields[8] as Location,
      dropoffLocation: fields[9] as Location,
      busRoute: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.grade)
      ..writeByte(3)
      ..write(obj.school)
      ..writeByte(4)
      ..write(obj.parentId)
      ..writeByte(5)
      ..write(obj.profileImage)
      ..writeByte(6)
      ..write(obj.specialNeeds)
      ..writeByte(7)
      ..write(obj.emergencyContacts)
      ..writeByte(8)
      ..write(obj.pickupLocation)
      ..writeByte(9)
      ..write(obj.dropoffLocation)
      ..writeByte(10)
      ..write(obj.busRoute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
