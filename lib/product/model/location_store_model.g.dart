// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_store_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationStoreModelAdapter extends TypeAdapter<LocationStoreModel> {
  @override
  final int typeId = 1;

  @override
  LocationStoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationStoreModel(
      isFinished: fields[0] as bool?,
      markers: (fields[1] as List?)?.cast<MarkerStoreModel>(),
      polylines: (fields[2] as List?)?.cast<LatlngStoreModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocationStoreModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isFinished)
      ..writeByte(1)
      ..write(obj.markers)
      ..writeByte(2)
      ..write(obj.polylines);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationStoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
