// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latlng_store_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LatlngStoreModelAdapter extends TypeAdapter<LatlngStoreModel> {
  @override
  final int typeId = 3;

  @override
  LatlngStoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LatlngStoreModel(
      latitude: fields[0] as double?,
      longitude: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, LatlngStoreModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatlngStoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
