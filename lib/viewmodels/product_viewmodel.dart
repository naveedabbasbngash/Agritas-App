import 'dart:async';
import 'dart:io'; // For SocketException
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/product_api.dart';
import '../utils/local_storage.dart';
import '../utils/logger.dart';

class ProductViewModel extends ChangeNotifier {
  List<Category> _categories = [];
  Category? _selectedCategory;
  String? _errorMessage;

  List<Category> get categories => _categories;
  String? get errorMessage => _errorMessage;
  Category? get selectedCategory => _selectedCategory;

  set selectedCategory(Category? category) {
    _selectedCategory = category;
    notifyListeners(); // Notify listeners to rebuild the UI when the selected category changes
  }

  Future<void> loadProducts(BuildContext context) async {
    Logger.log('Loading products...', tag: 'ProductViewModel');
    _errorMessage = null; // Reset error message before starting the loading process

    try {
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
        if (_categories.isEmpty) {
          Logger.log('No categories found in local storage.', tag: 'ProductViewModel');
        }
        notifyListeners(); // Update the UI with local storage data if available
      }

      // Step 2: Check connectivity before fetching fresh data
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _errorMessage = 'No internet connection. Showing offline data.';
        Logger.warn('No internet connection. Using cached or local data.', tag: 'ProductViewModel');
        notifyListeners();
        // Show a Snackbar to inform the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
        return; // Exit if there's no internet connection
      }

      // Step 3: Fetch fresh data in the background
      try {
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
      } on TimeoutException catch (e) {
        _errorMessage = 'The request timed out. Showing offline data.';
        Logger.error('Timeout while fetching fresh products: $e', tag: 'ProductViewModel');
      } on FormatException catch (e) {
        _errorMessage = 'Data format error. Please try again later.';
        Logger.error('Invalid format received from server: $e', tag: 'ProductViewModel');
      } on SocketException catch (e) {
        _errorMessage = 'Network error occurred. Please check your connection.';
        Logger.error('Network error while fetching products: $e', tag: 'ProductViewModel');
      } catch (e) {
        _errorMessage = 'Unexpected error occurred. Please try again later.';
        Logger.error('Unexpected error while fetching fresh products: $e', tag: 'ProductViewModel');
      }
    } catch (e) {
      _errorMessage = 'Error during product loading process. Please try again later.';
      Logger.error('Error during product loading process: $e', tag: 'ProductViewModel');
    } finally {
      notifyListeners(); // Ensure the UI is updated whether data is fetched or an error occurs
      // Show an error message to the user if one exists
      if (_errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      }
    }
  }
}
