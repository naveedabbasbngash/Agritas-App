import 'package:flutter/material.dart';

import '../models/servics_providers.dart';
import '../services/services_providers_api.dart';


class OfficerViewModel extends ChangeNotifier {
  List<Officer> _officers = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Officer> get officers => _officers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadOfficers(String city, String typeId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _officers = await OfficerServiceApi.fetchOfficers(city, typeId);
    } catch (e) {
      _errorMessage = 'Failed to load officers';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}