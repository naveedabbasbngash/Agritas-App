import 'dart:async';
import 'dart:io'; // For SocketException
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/dealer.dart';
import '../services/dearlers_api.dart';
import '../utils/logger.dart';
import '../utils/local_storage.dart'; // Import local storage utility for saving and retrieving cached data

class DealerViewModel extends ChangeNotifier {
  List<Dealer> _dealers = [];
  Dealer? _selectedDealer;
  String? _errorMessage;
  bool _isLoading = false;

  List<Dealer> get dealers => _dealers;
  String? get errorMessage => _errorMessage;
  Dealer? get selectedDealer => _selectedDealer;
  bool get isLoading => _isLoading;

  set selectedDealer(Dealer? dealer) {
    _selectedDealer = dealer;
    notifyListeners();
  }

  Future<void> loadDealers(BuildContext context) async {
    Logger.log('Loading dealers...', tag: 'DealerViewModel');
    _errorMessage = null; // Reset error message before starting the loading process
    _isLoading = true;
    notifyListeners(); // Notify UI of loading state

    try {
      // Step 1: Check for cached data in Hive first
      var dealerBox = await Hive.openBox<Dealer>('DealerBox');
      if (dealerBox.isNotEmpty) {
        Logger.log('Using cached dealers for optimistic UI update.', tag: 'DealerViewModel');
        _dealers = dealerBox.values.toList();
        notifyListeners(); // Update UI with cached data
      } else {
        Logger.log('No cached data found, checking local storage.', tag: 'DealerViewModel');
        _dealers = await LocalStorage.loadDealers(); // Load from local storage if available
        notifyListeners(); // Update UI with local data
      }

      // Step 2: Check connectivity before fetching fresh data
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _errorMessage = 'No internet connection. Showing offline data.';
        Logger.warn('No internet connection. Using cached or local data.', tag: 'DealerViewModel');
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
        return; // Exit if no internet connection
      }

      // Step 3: Fetch fresh data from the API in the background
      try {
        Logger.log('Internet connection available. Fetching fresh dealer data.', tag: 'DealerViewModel');
        final dealersFromServer = await DealerApi.getDealers(forceRefresh: true); // Fetch fresh data
        _dealers = dealersFromServer;

        // Save fresh data to Hive and local storage
        Logger.log('Saving fresh dealers to Hive and local storage.', tag: 'DealerViewModel');
        await dealerBox.clear(); // Clear existing data
        for (var dealer in _dealers) {
          await dealerBox.put(dealer.dealerId, dealer); // Add fresh data to Hive
        }
        await LocalStorage.saveDealers(_dealers); // Save to local storage

        notifyListeners(); // Update UI with fresh data
      } on SocketException catch (e) {
        _errorMessage = 'No internet connection. Showing offline data.';
        Logger.error('Network error while fetching dealers: $e', tag: 'DealerViewModel');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      } on TimeoutException catch (e) {
        _errorMessage = 'The request timed out. Showing offline data.';
        Logger.error('Timeout while fetching fresh dealers: $e', tag: 'DealerViewModel');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      } on FormatException catch (e) {
        _errorMessage = 'Data format error. Please try again later.';
        Logger.error('Invalid format received from server: $e', tag: 'DealerViewModel');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      } catch (e) {
        _errorMessage = 'Offline Mode Active! Check Your Internet Connection!';
        Logger.error('Unexpected error while fetching fresh dealers: $e', tag: 'DealerViewModel');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      }
    } catch (e) {
      _errorMessage = 'Error during dealer loading process. Please try again later.';
      Logger.error('Error during dealer loading process: $e', tag: 'DealerViewModel');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!)),
      );
    } finally {
      _isLoading = false;
      notifyListeners(); // Ensure the UI is updated whether data is fetched or an error occurs
    }
  }

  // Add a dealer to Hive
  Future<void> addDealer(Dealer dealer) async {
    try {
      var dealerBox = await Hive.openBox<Dealer>('dealers');
      await dealerBox.put(dealer.dealerId, dealer);
      _dealers.add(dealer);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error adding dealer: $e';
      notifyListeners();
    }
  }

  // Remove a dealer from Hive
  Future<void> removeDealer(String dealerId) async {
    try {
      var dealerBox = await Hive.openBox<Dealer>('dealers');
      await dealerBox.delete(dealerId);
      _dealers.removeWhere((dealer) => dealer.dealerId == dealerId);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error removing dealer: $e';
      notifyListeners();
    }
  }
}
