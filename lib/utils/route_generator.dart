import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailport/model/profile.dart';
import 'package:tailport/view/home_view/homepage.dart';
import 'package:tailport/view/profile_view/profile_page.dart';

const String splashScreen = 'splashScreen';
const String homeScreen = 'homeScreen';
const String profileScreen = 'profileScreen';

String currentRoute = splashScreen;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "";

    switch (settings.name) {
      case homeScreen:
        return CupertinoPageRoute(
          builder: (context) {
            return HomePage();
          },
        );

      case profileScreen:
        return CupertinoPageRoute(
          builder: (context) {
            return ProfilePage();
          },
        );

      default:
        return _errorRoute("Route not defined: ${settings.name}");
    }
  }

  static Route<dynamic> _errorRoute(String errorMessage) {
    return CupertinoPageRoute(builder: (context) {
      return Scaffold(body: Center(child: Text(errorMessage),));
    });
  }
}

class ScreenArguments {
  final String title;
  final List services;

  ScreenArguments(this.title, this.services);
}
