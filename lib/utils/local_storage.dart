import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/category.dart';
import '../models/crops.dart';
import '../models/problems.dart';

class LocalStorage {
  static const String _categoriesKey = 'categories';
  static const String _problemCategoryBoxName = 'ProblemBox';
  static Future<List<Category>> loadCategories() async {
    var box = await Hive.openBox<Category>('ProductBox');
    return box.values.toList();
  }

  static Future<void> saveCategories(List<Category> categories) async {
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


  // Save a list of ProblemCategory objects into Hive
  static Future<void> saveProblemCategories(List<ProblemCategory> problemCategories) async {
    // Open the Hive box for ProblemCategory
    var box = await Hive.openBox<ProblemCategory>(_problemCategoryBoxName);

    // Clear the existing data in the box (if any) before saving new data
    await box.clear();

    // Add each ProblemCategory into the Hive box
    for (var category in problemCategories) {
      await box.add(category);  // Each ProblemCategory will be added
    }
  }

  // Retrieve the saved ProblemCategory objects from the local storage (Hive)
  static List<ProblemCategory> getProblemCategoriesFromLocalStorage() {
    var box = Hive.box<ProblemCategory>(_problemCategoryBoxName);
    return box.values.toList().cast<ProblemCategory>();
  }
}
