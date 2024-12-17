// lib/view_model/theme_viewmodel.dart

import 'package:flutter/material.dart';

enum AppTheme {
  Material,
  Cupertino,
}

class ThemeViewModel extends ChangeNotifier {
  AppTheme _currentTheme = AppTheme.Material;

  AppTheme get currentTheme => _currentTheme;

  void toggleTheme() {
    if (_currentTheme == AppTheme.Material) {
      _currentTheme = AppTheme.Cupertino;
    } else {
      _currentTheme = AppTheme.Material;
    }
    notifyListeners();
  }

  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
