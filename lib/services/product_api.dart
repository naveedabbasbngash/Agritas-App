import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../utils/logger.dart';
import '../utils/local_storage.dart';

class ProductApi {
  static const String _baseUrl = 'https://www.agritas.com.pk/api/products/';
  static List<Category>? _cachedCategories;

  static Future<List<Category>> getProducts({bool forceRefresh = false}) async {
    if (_cachedCategories != null && !forceRefresh) {
      Logger.log('Returning cached categories', tag: 'ProductApi');
      return _cachedCategories!;
    }

    final url = Uri.parse('$_baseUrl/categories_products');
    Logger.log('Fetching products from $url', tag: 'ProductApi');

    try {
      final response = await http.get(url);

      Logger.apiResponse('Response status: ${response.statusCode}', tag: 'ProductApi');
      Logger.apiResponse('Response body: ${response.body}', tag: 'ProductApi');

      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = json.decode(response.body)['categories'];
        Logger.log('Parsed ${categoriesJson.length} categories', tag: 'ProductApi');
        _cachedCategories = categoriesJson.map((json) => Category.fromJson(json)).toList();

        // Save to local storage
        Logger.log('Saving products to local storage.', tag: 'ProductApi');
        await LocalStorage.saveCategories(_cachedCategories!);

        return _cachedCategories!;
      } else {
        Logger.error('Failed to load products: ${response.statusCode}', tag: 'ProductApi');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      Logger.error('Exception occurred: $e', tag: 'ProductApi');
      throw Exception('Failed to load products');
    }
  }

  static List<Category>? getCachedProducts() {
    return _cachedCategories;
  }
}
