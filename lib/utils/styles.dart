// lib/utils/styles.dart

import 'package:flutter/material.dart';
import 'package:tailport/utils/appcolors.dart';

class AppStyles {
  // Card Decoration with "Drawing Card" Aesthetic
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white, // Background color of the card
    border: Border.all(color: AppColors.lightPinkSecondary, width: 1.0), // Black border
    borderRadius: BorderRadius.circular(12.0), // Rounded corners
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05), // Subtle shadow
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 2), // Position of the shadow
      ),
    ],
  );

  // Elevated Button Style
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.lightPink, // Button background color
    foregroundColor: Colors.white, // Button text color
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    elevation: 3.0,
  );

  // Text Styles
  static TextStyle headlineStyle = const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static TextStyle subtitleStyle = const TextStyle(
    fontSize: 16.0,
    color: Colors.red,
  );

  // Input Decoration for Search Bar
  static InputDecoration searchInputDecoration = InputDecoration(
    hintText: 'Search pets...',
    prefixIcon: const Icon(Icons.search, color: Colors.black54),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none, // Removes the default border
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
  );
}
