import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../utils/logger.dart'; // Import the Logger utility

class ProductApi {
  static const String _baseUrl = 'https://www.agritas.com.pk/api/products/';

  static Future<List<Category>> getProducts() async {
    final url = Uri.parse('$_baseUrl/categories_products');
    Logger.log('Fetching products from $url', tag: 'ProductApi');

    try {
      final response = await http.get(url);

      Logger.apiResponse('Response status: ${response.statusCode}', tag: 'ProductApi');
      Logger.apiResponse('Response body: ${response.body}', tag: 'ProductApi');

      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = json.decode(response.body)['categories'];
        Logger.log('Parsed ${categoriesJson.length} categories', tag: 'ProductApi');
        return categoriesJson.map((json) => Category.fromJson(json)).toList();
      } else {
        Logger.error('Failed to load products: ${response.statusCode}', tag: 'ProductApi');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      Logger.error('Exception occurred: $e', tag: 'ProductApi');
      throw Exception('Failed to load products');
    }
  }
}
