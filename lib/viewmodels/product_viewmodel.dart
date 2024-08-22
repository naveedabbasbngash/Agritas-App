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

    try {
      // Check the connectivity status
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection, load from local storage
        Logger.log('No internet connection. Loading products from local storage.', tag: 'ProductViewModel');
        _categories = await LocalStorage.loadCategories();
      } else {
        // Internet connection is available, load from server
        Logger.log('Internet connection available. Loading products from server.', tag: 'ProductViewModel');
        final categoriesFromServer = await ProductApi.getProducts();
        _categories = categoriesFromServer;

        // Set the default selected category if not already selected
        if (_selectedCategory == null && _categories.isNotEmpty) {
          _selectedCategory = _categories.first;
        }

        // Save to local storage
        Logger.log('Saving products to local storage.', tag: 'ProductViewModel');
        await LocalStorage.saveCategories(_categories);
      }

      notifyListeners(); // Update the UI
    } catch (e) {
      Logger.error('Error loading products: $e', tag: 'ProductViewModel');
      // Optionally, load from local storage as a fallback in case of an error
      try {
        Logger.log('Attempting to load products from local storage after error.', tag: 'ProductViewModel');
        _categories = await LocalStorage.loadCategories();
        notifyListeners();
      } catch (localError) {
        Logger.error('Error loading products from local storage: $localError', tag: 'ProductViewModel');
      }
    }
  }
}
