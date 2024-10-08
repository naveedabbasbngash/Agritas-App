import 'package:hive/hive.dart';

part '../providers/product_provider.g.dart'; // This part file will be generated by Hive

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final String productId;
  @HiveField(1)
  final String productName;
  @HiveField(2)
  final String urProductName;
  @HiveField(3)
  final String packSize;
  @HiveField(4)
  final String composition;
  @HiveField(5)
  final String compositionUr;
  @HiveField(6)
  final String modeOfAction;
  @HiveField(7)
  final String modeOfActionUr;
  @HiveField(8)
  final String application;
  @HiveField(9)
  final String applicationUr;
  @HiveField(10)
  final String imageUrl;
  @HiveField(11)
  final String description;
  @HiveField(12)
  final String setas;
  @HiveField(13)
  final String catId;
  @HiveField(14)
  final String isDeleted;
  @HiveField(15)
  final String brochurePath;
  @HiveField(16)
  final String categoryName;
  @HiveField(17)
  final String urCategoryName;
  @HiveField(18)
  final String descriptions;

  Product({
    required this.productId,
    required this.productName,
    required this.urProductName,
    required this.packSize,
    required this.composition,
    required this.compositionUr,
    required this.modeOfAction,
    required this.modeOfActionUr,
    required this.application,
    required this.applicationUr,
    required this.imageUrl,
    required this.description,
    required this.setas,
    required this.catId,
    required this.isDeleted,
    required this.brochurePath,
    required this.categoryName,
    required this.urCategoryName,
    required this.descriptions,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      urProductName: json['ur_product_name'] ?? '',
      packSize: json['pack_size'],
      composition: json['composition'],
      compositionUr: json['composition_ur'] ?? '',
      modeOfAction: json['mode_of_action'],
      modeOfActionUr: json['mode_of_action_ur'] ?? '',
      application: json['application'],
      applicationUr: json['application_ur'] ?? '',
      imageUrl: json['image_url'],
      description: json['description'],
      setas: json['setas'],
      catId: json['cat_id'],
      isDeleted: json['is_deleted'],
      brochurePath: json['brochure_path'] ?? '',
      categoryName: json['category_name'],
      urCategoryName: json['ur_category_name'] ?? '',
      descriptions: json['descriptions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'ur_product_name': urProductName,
      'pack_size': packSize,
      'composition': composition,
      'composition_ur': compositionUr,
      'mode_of_action': modeOfAction,
      'mode_of_action_ur': modeOfActionUr,
      'application': application,
      'application_ur': applicationUr,
      'image_url': imageUrl,
      'description': description,
      'setas': setas,
      'cat_id': catId,
      'is_deleted': isDeleted,
      'brochure_path': brochurePath,
      'category_name': categoryName,
      'ur_category_name': urCategoryName,
      'descriptions': descriptions,
    };
  }
}
