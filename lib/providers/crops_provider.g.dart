// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/crops.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CropAdapter extends TypeAdapter<Crop> {
  @override
  final int typeId = 2;

  @override
  Crop read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Crop(
      cropId: fields[0] as String,
      cropName: fields[1] as String,
      cropNameUr: fields[2] as String,
      description: fields[3] as String,
      descriptionUr: fields[4] as String,
      imgUrl: fields[5] as String,
      pdfUrl: fields[6] as String,
      isDeleted: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Crop obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.cropId)
      ..writeByte(1)
      ..write(obj.cropName)
      ..writeByte(2)
      ..write(obj.cropNameUr)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.descriptionUr)
      ..writeByte(5)
      ..write(obj.imgUrl)
      ..writeByte(6)
      ..write(obj.pdfUrl)
      ..writeByte(7)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CropAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
