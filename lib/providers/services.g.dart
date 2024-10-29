// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/services.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceAdapter extends TypeAdapter<Service> {
  @override
  final int typeId = 6;

  @override
  Service read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Service(
      typeId: fields[0] as String,
      typeName: fields[1] as String,
      typeImageUrl: fields[2] as String,
      typeDescription: fields[3] as String,
      serviceStatus: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Service obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.typeId)
      ..writeByte(1)
      ..write(obj.typeName)
      ..writeByte(2)
      ..write(obj.typeImageUrl)
      ..writeByte(3)
      ..write(obj.typeDescription)
      ..writeByte(4)
      ..write(obj.serviceStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
