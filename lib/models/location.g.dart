// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 5;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      id: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      coordinates: (fields[3] as List).cast<double>(),
      type: fields[4] as LocationType,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.coordinates)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationTypeAdapter extends TypeAdapter<LocationType> {
  @override
  final int typeId = 4;

  @override
  LocationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LocationType.home;
      case 1:
        return LocationType.school;
      case 2:
        return LocationType.pickup;
      case 3:
        return LocationType.dropoff;
      default:
        return LocationType.home;
    }
  }

  @override
  void write(BinaryWriter writer, LocationType obj) {
    switch (obj) {
      case LocationType.home:
        writer.writeByte(0);
        break;
      case LocationType.school:
        writer.writeByte(1);
        break;
      case LocationType.pickup:
        writer.writeByte(2);
        break;
      case LocationType.dropoff:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
