import 'package:agritas_app/services/services_api.dart';
import 'package:flutter/material.dart';

import '../models/services.dart';

class ServiceViewModel extends ChangeNotifier {
  List<Service> _services = [];
  String? _errorMessage;

  List<Service> get services => _services;
  String? get errorMessage => _errorMessage;

  /// Load services either from cache or via API
  Future<void> loadServices({bool forceRefresh = false}) async {
    try {
      _errorMessage = null; // Reset error message before fetching

      // If forceRefresh is true or cached services are not available, fetch fresh data
      if (_services.isEmpty || forceRefresh) {
        _services = await ServicesApi.getServices(forceRefresh: forceRefresh);
      } else {
        _services = ServicesApi.getCachedServices() ?? [];
      }

      // Notify listeners to rebuild the UI
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load services: $e';
      notifyListeners();
    }
  }
}
