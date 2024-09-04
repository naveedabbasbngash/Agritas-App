import 'dart:async';
import 'dart:io'; // For SocketException
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../models/problems.dart';
import '../services/problems_api.dart'; // Import your ProblemsApi service
import '../utils/local_storage.dart';
import '../utils/logger.dart';

class ProblemsViewModel extends ChangeNotifier {
  List<ProblemCategory> _problemCategories = [];
  ProblemCategory? _selectedProblemCategory;
  String? _errorMessage;

  List<ProblemCategory> get problemCategories => _problemCategories;
  String? get errorMessage => _errorMessage;
  ProblemCategory? get selectedProblemCategory => _selectedProblemCategory;

  set selectedProblemCategory(ProblemCategory? category) {
    _selectedProblemCategory = category;
    notifyListeners(); // Notify listeners to rebuild the UI when the selected problem category changes
  }

  Future<void> loadProblems(BuildContext context) async {
    Logger.log('Loading problems...', tag: 'ProblemsViewModel');
    _errorMessage = null; // Reset error message before starting the loading process

    try {
      // Step 1: Check for cached data first
      List<ProblemCategory>? cachedProblems = ProblemsApi.getCachedProblemCategories();
      if (cachedProblems != null && cachedProblems.isNotEmpty) {
        Logger.log('Using cached problems for optimistic UI update.', tag: 'ProblemsViewModel');
        _problemCategories = cachedProblems;
        notifyListeners(); // Immediately update the UI with cached data
      } else {
        // If no cache, check local storage
        Logger.log('No cached data found, loading from local storage.', tag: 'ProblemsViewModel');
        _problemCategories = await LocalStorage.getProblemCategoriesFromLocalStorage();
        if (_problemCategories.isEmpty) {
          Logger.log('No problems found in local storage.', tag: 'ProblemsViewModel');
        }
        notifyListeners(); // Update the UI with local storage data if available
      }

      // Step 2: Check connectivity before fetching fresh data
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _errorMessage = 'No internet connection. Showing offline data.';
        Logger.warn('No internet connection. Using cached or local data.', tag: 'ProblemsViewModel');
        notifyListeners();
        // Show a Snackbar to inform the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
        return; // Exit if there's no internet connection
      }

      // Step 3: Fetch fresh data in the background
      try {
        Logger.log('Internet connection available. Fetching fresh data.', tag: 'ProblemsViewModel');
        final problemsFromServer = await ProblemsApi.getProblemCategories(forceRefresh: true);
        _problemCategories = problemsFromServer;

        // Set the default selected problem category if not already selected
        if (_selectedProblemCategory == null && _problemCategories.isNotEmpty) {
          _selectedProblemCategory = _problemCategories.first;
        }

        // Save fresh data to local storage
        Logger.log('Saving fresh problems to local storage.', tag: 'ProblemsViewModel');
        await LocalStorage.saveProblemCategories(_problemCategories);

        notifyListeners(); // Update the UI with fresh data
      } on TimeoutException catch (e) {
        _errorMessage = 'The request timed out. Showing offline data.';
        Logger.error('Timeout while fetching fresh problems: $e', tag: 'ProblemsViewModel');
      } on FormatException catch (e) {
        _errorMessage = 'Data format error. Please try again later.';
        Logger.error('Invalid format received from server: $e', tag: 'ProblemsViewModel');
      } on SocketException catch (e) {
        _errorMessage = 'Network error occurred. Please check your connection.';
        Logger.error('Network error while fetching problems: $e', tag: 'ProblemsViewModel');
      } catch (e) {
        _errorMessage = 'Offline Mode Active! Check Your Internet Connection!';
        Logger.error('Unexpected error while fetching fresh problems: $e', tag: 'ProblemsViewModel');
      }
    } catch (e) {
      _errorMessage = 'Error during problems loading process. Please try again later.';
      Logger.error('Error during problems loading process: $e', tag: 'ProblemsViewModel');
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
