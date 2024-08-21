import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/category.dart';

class LocalStorage {
  static const String _categoriesKey = 'categories';

  static Future<void> saveCategories(List<Category> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final String categoriesJson = jsonEncode(categories.map((c) => c.toJson()).toList());
    await prefs.setString(_categoriesKey, categoriesJson);
  }

  static Future<List<Category>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? categoriesJson = prefs.getString(_categoriesKey);

    if (categoriesJson != null) {
      final List<dynamic> categoriesList = jsonDecode(categoriesJson);
      return categoriesList.map((json) => Category.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
