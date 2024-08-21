import 'package:hive/hive.dart';
import 'product.dart';
part '../providers/category_provider.dart';  // This is required for Hive code generation

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final String categoryId;
  @HiveField(1)
  final String categoryName;
  @HiveField(2)
  final String urCategoryName;
  @HiveField(3)
  final List<Product> products;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.urCategoryName,
    required this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['cat_id'],
      categoryName: json['category_name'],
      urCategoryName: json['ur_category_name'] ?? '',
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_id': categoryId,
      'category_name': categoryName,
      'ur_category_name': urCategoryName,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
