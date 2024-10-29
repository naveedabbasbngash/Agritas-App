import 'package:agritas_app/models/dealer.dart';
import 'package:agritas_app/models/services.dart';
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


  static Future<List<Dealer>> loadDealers() async {
    var box = await Hive.openBox<Dealer>('DealerBox');
    return box.values.toList();
  }

  static Future<void> saveDealers(List<Dealer> dealer) async {
    var box = await Hive.openBox<Dealer>('DealerBox');
    await box.clear();
    await box.addAll(dealer);
  }


  static Future<List<Service>> loadServices() async {
    var box = await Hive.openBox<Service>('ServiceBox');
    return box.values.toList();
  }

  static Future<void> saveServices(List<Service> services) async {
    var box = await Hive.openBox<Service>('ServiceBox');
    await box.clear();
    await box.addAll(services);
  }




}
