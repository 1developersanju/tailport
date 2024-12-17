// lib/view_model/profile_viewmodel.dart

import 'package:flutter/material.dart';
import '../model/profile.dart';

class ProfileViewModel extends ChangeNotifier {
  Profile _profile = Profile(
    userName: 'sidharth',
    profileImageUrl:
        'https://images.unsplash.com/photo-1697602251148-2e982bf40c5c?w=400&auto=format&fit=crop&q=60',
    contactNumber: '+91 12345 67890',
    email: 'sidharth@tailport.in',
    isAuthorizedSeller: true,
    petsSold: 3,
    petsAdopted: 5,
    petsForSale: 2,
    petsForAdoption: 1,
    preferredLanguage: 'English',
    theme: 'Light',
    address: '123 Tailport Street, Pet City, TX',
  );

  Profile get profile => _profile;

  void updateProfile(Profile updatedProfile) {
    _profile = updatedProfile;
    notifyListeners();
  }

  void toggleTheme() {
    _profile = Profile(
      userName: _profile.userName,
      profileImageUrl: _profile.profileImageUrl,
      contactNumber: _profile.contactNumber,
      email: _profile.email,
      isAuthorizedSeller: _profile.isAuthorizedSeller,
      petsSold: _profile.petsSold,
      petsAdopted: _profile.petsAdopted,
      petsForSale: _profile.petsForSale,
      petsForAdoption: _profile.petsForAdoption,
      preferredLanguage: _profile.preferredLanguage,
      theme: _profile.theme == 'Light' ? 'Dark' : 'Light',
      address: _profile.address,
    );
    notifyListeners();
  }

  void updateLanguage(String language) {
    _profile = Profile(
      userName: _profile.userName,
      profileImageUrl: _profile.profileImageUrl,
      contactNumber: _profile.contactNumber,
      email: _profile.email,
      isAuthorizedSeller: _profile.isAuthorizedSeller,
      petsSold: _profile.petsSold,
      petsAdopted: _profile.petsAdopted,
      petsForSale: _profile.petsForSale,
      petsForAdoption: _profile.petsForAdoption,
      preferredLanguage: language,
      theme: _profile.theme,
      address: _profile.address,
    );
    notifyListeners();
  }
}
