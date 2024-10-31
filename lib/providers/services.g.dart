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
      cities: (fields[5] as List?)?.cast<City>(),
    );
  }

  @override
  void write(BinaryWriter writer, Service obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.typeId)
      ..writeByte(1)
      ..write(obj.typeName)
      ..writeByte(2)
      ..write(obj.typeImageUrl)
      ..writeByte(3)
      ..write(obj.typeDescription)
      ..writeByte(4)
      ..write(obj.serviceStatus)
      ..writeByte(5)
      ..write(obj.cities);
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

class CityAdapter extends TypeAdapter<City> {
  @override
  final int typeId = 8;

  @override
  City read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return City(
      cityId: fields[0] as String,
      cityName: fields[1] as String,
      cityImage: fields[2] as String,
      cityStatus: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, City obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cityId)
      ..writeByte(1)
      ..write(obj.cityName)
      ..writeByte(2)
      ..write(obj.cityImage)
      ..writeByte(3)
      ..write(obj.cityStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
