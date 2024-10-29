// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/dealer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DealerAdapter extends TypeAdapter<Dealer> {
  @override
  final int typeId = 5;

  @override
  Dealer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dealer(
      dealerId: fields[0] as String,
      dealerName: fields[1] as String,
      urDealerName: fields[2] as String,
      dealerAddress: fields[3] as String,
      urDealerAddress: fields[4] as String,
      dealerContact: fields[5] as String,
      geoLocation: fields[6] as String,
      isDeleted: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dealer obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.dealerId)
      ..writeByte(1)
      ..write(obj.dealerName)
      ..writeByte(2)
      ..write(obj.urDealerName)
      ..writeByte(3)
      ..write(obj.dealerAddress)
      ..writeByte(4)
      ..write(obj.urDealerAddress)
      ..writeByte(5)
      ..write(obj.dealerContact)
      ..writeByte(6)
      ..write(obj.geoLocation)
      ..writeByte(7)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
