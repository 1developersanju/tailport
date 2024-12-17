// localization_view_model.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationViewModel extends ChangeNotifier {
  Locale _currentLocale = Locale('en');

  Locale get currentLocale => _currentLocale;

  LocalizationViewModel() {
    _loadLocale();
  }

  // Load the saved locale from SharedPreferences
  Future<void> _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localeCode = prefs.getString('locale');
    if (localeCode != null) {
      _currentLocale = Locale(localeCode);
      notifyListeners();
    }
  }

  // Change the locale and save it to SharedPreferences
  Future<void> changeLocale(Locale newLocale) async {
    _currentLocale = newLocale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', newLocale.languageCode);
    notifyListeners();
  }
}
