// lib/view/auth_wrapper.dart

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tailport/utils/app_localizations.dart';
import 'package:tailport/view/home_view/homepage.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return AnimatedSplashScreen(
      backgroundColor: Theme.of(context).colorScheme.background, // Use theme's background color
      splashTransition: SplashTransition.fadeTransition,
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Optional: Add a logo or image above the text
            // Image.asset(
            //   'assets/images/logo.png',
            //   height: height * 0.2,
            // ),
            SizedBox(height: height * 0.05), // Spacing between logo and text
            Text(
              AppLocalizations.of(context)!.translate('tail_port'), // Ensure 'tail_port' key exists in JSON
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    // Additional styling if needed
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      nextScreen: const HomePage(),
      duration: 3000, // Duration of the splash screen in milliseconds
      splashIconSize: height * 0.3, // Adjust the splash icon size as needed
      animationDuration: const Duration(milliseconds: 1000), // Animation duration
      // Optionally, you can add a splash background image or color
    );
  }
}
