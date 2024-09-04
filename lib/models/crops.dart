import 'package:hive/hive.dart';

part '../providers/crops_provider.g.dart';

@HiveType(typeId: 2)
class Crop {
  @HiveField(0)
  final String cropId;
  @HiveField(1)
  final String cropName;
  @HiveField(2)
  final String cropNameUr;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String descriptionUr;
  @HiveField(5)
  final String imgUrl;
  @HiveField(6)
  final String pdfUrl;
  @HiveField(7)
  final String isDeleted;

  Crop({
    required this.cropId,
    required this.cropName,
    required this.cropNameUr,
    required this.description,
    required this.descriptionUr,
    required this.imgUrl,
    required this.pdfUrl,
    required this.isDeleted,
  });

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      cropId: json['crop_id'],
      cropName: json['crop_name'],
      cropNameUr: json['crop_name_ur'] ?? '',
      description: json['description'],
      descriptionUr: json['description_ur'] ?? '',
      imgUrl: json['img_url'],
      pdfUrl: json['pdf_url'] ?? '',
      isDeleted: json['is_deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'crop_id': cropId,
      'crop_name': cropName,
      'crop_name_ur': cropNameUr,
      'description': description,
      'description_ur': descriptionUr,
      'img_url': imgUrl,
      'pdf_url': pdfUrl,
      'is_deleted': isDeleted,
    };
  }
}
