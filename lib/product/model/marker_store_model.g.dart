// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_store_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarkerStoreModelAdapter extends TypeAdapter<MarkerStoreModel> {
  @override
  final int typeId = 2;

  @override
  MarkerStoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarkerStoreModel(
      markerId: fields[0] as String?,
      markerLat: fields[1] as double?,
      markerLong: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, MarkerStoreModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.markerId)
      ..writeByte(1)
      ..write(obj.markerLat)
      ..writeByte(2)
      ..write(obj.markerLong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkerStoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
