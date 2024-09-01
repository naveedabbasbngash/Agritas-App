import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/category.dart';
import '../models/crops.dart';

class LocalStorage {
  static const String _categoriesKey = 'categories';
  static Future<List<Category>> loadCategories() async {
    /*
    final prefs = await SharedPreferences.getInstance();
    final String? categoriesJson = prefs.getString(_categoriesKey);

    if (categoriesJson != null) {
      final List<dynamic> categoriesList = jsonDecode(categoriesJson);
      return categoriesList.map((json) => Category.fromJson(json)).toList();
    } else {
      return [];
    }*/

    var box = await Hive.openBox<Category>('ProductBox');
    return box.values.toList();
  }

  static Future<void> saveCategories(List<Category> categories) async {
/*    final prefs = await SharedPreferences.getInstance();
    final String categoriesJson = jsonEncode(categories.map((c) => c.toJson()).toList());
    await prefs.setString(_categoriesKey, categoriesJson);*/
    var box = await Hive.openBox<Category>('ProductBox');
    await box.clear();
    await box.addAll(categories);
  }


  static Future<List<Crop>> loadCrops() async {
    var box = await Hive.openBox<Crop>('cropsBox');
    return box.values.toList();
  }


  static Future<void> saveCrops(List<Crop> crops) async {
    var box = await Hive.openBox<Crop>('cropsBox');
    await box.clear();
    await box.addAll(crops);
  }
}
