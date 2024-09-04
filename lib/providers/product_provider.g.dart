// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      productId: fields[0] as String,
      productName: fields[1] as String,
      urProductName: fields[2] as String,
      packSize: fields[3] as String,
      composition: fields[4] as String,
      compositionUr: fields[5] as String,
      modeOfAction: fields[6] as String,
      modeOfActionUr: fields[7] as String,
      application: fields[8] as String,
      applicationUr: fields[9] as String,
      imageUrl: fields[10] as String,
      description: fields[11] as String,
      setas: fields[12] as String,
      catId: fields[13] as String,
      isDeleted: fields[14] as String,
      brochurePath: fields[15] as String,
      categoryName: fields[16] as String,
      urCategoryName: fields[17] as String,
      descriptions: fields[18] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.urProductName)
      ..writeByte(3)
      ..write(obj.packSize)
      ..writeByte(4)
      ..write(obj.composition)
      ..writeByte(5)
      ..write(obj.compositionUr)
      ..writeByte(6)
      ..write(obj.modeOfAction)
      ..writeByte(7)
      ..write(obj.modeOfActionUr)
      ..writeByte(8)
      ..write(obj.application)
      ..writeByte(9)
      ..write(obj.applicationUr)
      ..writeByte(10)
      ..write(obj.imageUrl)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.setas)
      ..writeByte(13)
      ..write(obj.catId)
      ..writeByte(14)
      ..write(obj.isDeleted)
      ..writeByte(15)
      ..write(obj.brochurePath)
      ..writeByte(16)
      ..write(obj.categoryName)
      ..writeByte(17)
      ..write(obj.urCategoryName)
      ..writeByte(18)
      ..write(obj.descriptions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
