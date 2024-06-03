import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Notify listeners to trigger a rebuild
  }

    /// Clear AUth Provider
  clearProvider() {
   _isDarkMode = false;
    
  }
}
