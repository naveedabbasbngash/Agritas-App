// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/problems.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProblemCategoryAdapter extends TypeAdapter<ProblemCategory> {
  @override
  final int typeId = 3;

  @override
  ProblemCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProblemCategory(
      pc_id: fields[0] as String,
      pc_name_en: fields[1] as String,
      pc_name_ur: fields[2] as String,
      cat_image_url: fields[3] as String,
      problems: (fields[4] as List).cast<Problem>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProblemCategory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.pc_id)
      ..writeByte(1)
      ..write(obj.pc_name_en)
      ..writeByte(2)
      ..write(obj.pc_name_ur)
      ..writeByte(3)
      ..write(obj.cat_image_url)
      ..writeByte(4)
      ..write(obj.problems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProblemCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProblemAdapter extends TypeAdapter<Problem> {
  @override
  final int typeId = 4;

  @override
  Problem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Problem(
      problem_id: fields[0] as String,
      problem_name: fields[1] as String,
      problem_name_ur: fields[2] as String,
      description_en: fields[3] as String,
      description_ur: fields[4] as String,
      img_url: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Problem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.problem_id)
      ..writeByte(1)
      ..write(obj.problem_name)
      ..writeByte(2)
      ..write(obj.problem_name_ur)
      ..writeByte(3)
      ..write(obj.description_en)
      ..writeByte(4)
      ..write(obj.description_ur)
      ..writeByte(5)
      ..write(obj.img_url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProblemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
