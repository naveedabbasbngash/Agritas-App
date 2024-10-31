// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/servics_providers.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfficerAdapter extends TypeAdapter<Officer> {
  @override
  final int typeId = 7;

  @override
  Officer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Officer(
      id: fields[0] as String,
      typeId: fields[1] as String,
      cityId: fields[2] as String,
      providerName: fields[3] as String,
      providerContact: fields[4] as String,
      cost: fields[5] as String,
      providerImageUrls: fields[6] as String,
      latLong: fields[7] as String,
      serviceDescription: fields[8] as String,
      typeName: fields[9] as String,
      cityName: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Officer obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeId)
      ..writeByte(2)
      ..write(obj.cityId)
      ..writeByte(3)
      ..write(obj.providerName)
      ..writeByte(4)
      ..write(obj.providerContact)
      ..writeByte(5)
      ..write(obj.cost)
      ..writeByte(6)
      ..write(obj.providerImageUrls)
      ..writeByte(7)
      ..write(obj.latLong)
      ..writeByte(8)
      ..write(obj.serviceDescription)
      ..writeByte(9)
      ..write(obj.typeName)
      ..writeByte(10)
      ..write(obj.cityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfficerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
