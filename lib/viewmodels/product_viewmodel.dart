import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/product_api.dart';
import '../utils/local_storage.dart';
import '../utils/logger.dart';

class ProductViewModel extends ChangeNotifier {
  List<Category> _categories = [];
  Category? _selectedCategory;

  List<Category> get categories => _categories;

  Category? get selectedCategory => _selectedCategory;

  set selectedCategory(Category? category) {
    _selectedCategory = category;
    notifyListeners(); // Notify listeners to rebuild the UI when the selected category changes
  }

  Future<void> loadProducts() async {
    Logger.log('Loading products...', tag: 'ProductViewModel');

    // Step 1: Check for cached data first
    List<Category>? cachedCategories = ProductApi.getCachedProducts();
    if (cachedCategories != null && cachedCategories.isNotEmpty) {
      Logger.log('Using cached categories for optimistic UI update.', tag: 'ProductViewModel');
      _categories = cachedCategories;
      notifyListeners(); // Immediately update the UI with cached data
    } else {
      // If no cache, check local storage
      Logger.log('No cached data found, loading from local storage.', tag: 'ProductViewModel');
      _categories = await LocalStorage.loadCategories();
      notifyListeners(); // Update the UI with local storage data if available
    }

    // Step 2: Fetch fresh data in the background
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        Logger.log('Internet connection available. Fetching fresh data.', tag: 'ProductViewModel');
        final categoriesFromServer = await ProductApi.getProducts(forceRefresh: true);
        _categories = categoriesFromServer;

        // Set the default selected category if not already selected
        if (_selectedCategory == null && _categories.isNotEmpty) {
          _selectedCategory = _categories.first;
        }

        // Save fresh data to local storage
        Logger.log('Saving fresh products to local storage.', tag: 'ProductViewModel');
        await LocalStorage.saveCategories(_categories);

        notifyListeners(); // Update the UI with fresh data
      }
    } catch (e) {
      Logger.error('Error fetching fresh products: $e', tag: 'ProductViewModel');
    }
  }
}
