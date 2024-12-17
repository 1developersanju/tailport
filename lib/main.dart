// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailport/utils/app_localizations.dart';
import 'package:tailport/utils/appcolors.dart';
import 'package:tailport/utils/route_generator.dart';
import 'package:tailport/view/auth/auth_wrapper.dart';
import 'package:tailport/view/home_view/homepage.dart';
import 'package:tailport/view_model/home_viewmodel.dart';
import 'package:tailport/view_model/localization_viewmodel.dart';
import 'package:tailport/view_model/profile_viewmodel.dart';
import 'package:tailport/view_model/theme_viewmodel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalizationViewModel()),
                ChangeNotifierProvider(create: (_) => HomeViewModel()),
                ChangeNotifierProvider(create: (_) => ProfileViewModel()),

        ChangeNotifierProvider(
            create: (_) => ThemeViewModel()), // Added ThemeViewModel
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // Helper function to create a MaterialColor from a single Color
  MaterialColor createMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    // Listen to LocalizationViewModel and ThemeViewModel
    return Consumer2<LocalizationViewModel, ThemeViewModel>(
        builder: (context, localizationViewModel, themeViewModel, child) {
      // Determine which theme to use
      // Inside your main.dart within the ThemeData setup

     ThemeData currentTheme;
if (themeViewModel.currentTheme == AppTheme.Material) {
  currentTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPurple,        // Primary color
      primaryContainer: AppColors.lightPink, // Primary container
      secondary: AppColors.pink,             // Secondary color
      secondaryContainer: AppColors.veryLightPink, // Secondary container
      background: AppColors.cream,           // Background color
      surface: AppColors.lightBeige,         // Surface color
      onPrimary: AppColors.white,            // Text/Icon color on primary
      onSecondary: AppColors.black,          // Text/Icon color on secondary
      onBackground: AppColors.black,         // Text color on background
      onSurface: AppColors.black,            // Text color on surface
    ),
    scaffoldBackgroundColor: AppColors.cream,
    cardColor: AppColors.lightBeige,
    hintColor: AppColors.pink,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightPurple,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightBeige,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.purple,
      unselectedItemColor: AppColors.lightPinkSecondary,
      selectedIconTheme: IconThemeData(
        size: 28,
        color: AppColors.purple,
      ),
      unselectedIconTheme: IconThemeData(
        size: 24,
        color: AppColors.lightPinkSecondary,
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.purple,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.purple,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.purple,
        side: const BorderSide(color: AppColors.purple, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.black,
      size: 24,
    ),

    // Text Theme
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.lightPinkSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    ),

    // Card Theme
    cardTheme: const CardTheme(
      color: AppColors.lightBeige,
      shadowColor: AppColors.veryLightPink,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
    ),
  );
} else {
  // Cupertino-like Theme
  currentTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.pink,
      primaryContainer: AppColors.lightPink,
      secondary: AppColors.lightPurple,
      secondaryContainer: AppColors.veryLightPink,
      background: AppColors.cream,
      surface: AppColors.lightBeige,
      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
      onBackground: AppColors.black,
      onSurface: AppColors.black,
    ),
    scaffoldBackgroundColor: AppColors.cream,
    cardColor: AppColors.lightBeige,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.pink,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
  );
}


      return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Tailport',
        locale: localizationViewModel.currentLocale,
        supportedLocales: const [
          Locale('en', ''), // English
          Locale('ta', ''), // Tamil
          Locale('hi', ''), // Hindi
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: currentTheme, // Ensure the updated ThemeData is applied
        home: const AuthWrapper(), // Initial screen with splash
        onGenerateRoute: RouteGenerator.generateRoute,
      );
    });
  }
}
