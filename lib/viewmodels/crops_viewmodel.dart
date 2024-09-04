import 'dart:async';
import 'dart:io'; // For SocketException
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../models/crops.dart';
import '../services/crops_api.dart';
import '../utils/local_storage.dart';
import '../utils/logger.dart';

class CropsViewModel extends ChangeNotifier {
  List<Crop> _crops = [];
  Crop? _selectedCrop;
  String? _errorMessage;

  List<Crop> get crops => _crops;
  String? get errorMessage => _errorMessage;
  Crop? get selectedCrop => _selectedCrop;

  set selectedCrop(Crop? crop) {
    _selectedCrop = crop;
    notifyListeners(); // Notify listeners to rebuild the UI when the selected crop changes
  }

  Future<void> loadCrops(BuildContext context) async {
    Logger.log('Loading crops...', tag: 'CropsViewModel');
    _errorMessage = null; // Reset error message before starting the loading process

    try {
      // Step 1: Check for cached data first
      List<Crop>? cachedCrops = CropsApi.getCachedCrops();
      if (cachedCrops != null && cachedCrops.isNotEmpty) {
        Logger.log('Using cached crops for optimistic UI update.', tag: 'CropsViewModel');
        _crops = cachedCrops;
        notifyListeners(); // Immediately update the UI with cached data
      } else {
        // If no cache, check local storage
        Logger.log('No cached data found, loading from local storage.', tag: 'CropsViewModel');
        _crops = await LocalStorage.loadCrops();
        if (_crops.isEmpty) {
          Logger.log('No crops found in local storage.', tag: 'CropsViewModel');
        }
        notifyListeners(); // Update the UI with local storage data if available
      }

      // Step 2: Check connectivity before fetching fresh data
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _errorMessage = 'No internet connection. Showing offline data.';
        Logger.warn('No internet connection. Using cached or local data.', tag: 'CropsViewModel');
        notifyListeners();
        // Show a Snackbar to inform the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
        return; // Exit if there's no internet connection
      }

      // Step 3: Fetch fresh data in the background
      try {
        Logger.log('Internet connection available. Fetching fresh data.', tag: 'CropsViewModel');
        final cropsFromServer = await CropsApi.getCrops(forceRefresh: true);
        _crops = cropsFromServer;

        // Set the default selected crop if not already selected
        if (_selectedCrop == null && _crops.isNotEmpty) {
          _selectedCrop = _crops.first;
        }

        // Save fresh data to local storage
        Logger.log('Saving fresh crops to local storage.', tag: 'CropsViewModel');
        await LocalStorage.saveCrops(_crops);

        notifyListeners(); // Update the UI with fresh data
      } on TimeoutException catch (e) {
        _errorMessage = 'The request timed out. Showing offline data.';
        Logger.error('Timeout while fetching fresh crops: $e', tag: 'CropsViewModel');
      } on FormatException catch (e) {
        _errorMessage = 'Data format error. Please try again later.';
        Logger.error('Invalid format received from server: $e', tag: 'CropsViewModel');
      } on SocketException catch (e) {
        _errorMessage = 'Network error occurred. Please check your connection.';
        Logger.error('Network error while fetching crops: $e', tag: 'CropsViewModel');
      } catch (e) {
        _errorMessage = 'Offline Mode Active! Check Your Internat Connection!';
        Logger.error('Unexpected error while fetching fresh crops: $e', tag: 'CropsViewModel');
      }
    } catch (e) {
      _errorMessage = 'Error during crops loading process. Please try again later.';
      Logger.error('Error during crops loading process: $e', tag: 'CropsViewModel');
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
