import 'package:flutter/material.dart';

class LanguageViewModel extends ChangeNotifier {
  String _selectedLanguage = 'en'; // Default to English

  String get selectedLanguage => _selectedLanguage;

  void selectLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}
