import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailport/utils/route_generator.dart';
import 'package:tailport/view_model/profile_viewmodel.dart';

class WelcomeBanner extends StatefulWidget {
  final String message; // Dynamic welcome message

  const WelcomeBanner({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  _WelcomeBannerState createState() => _WelcomeBannerState();
}

class _WelcomeBannerState extends State<WelcomeBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _swingAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Define the swing animation
    _swingAnimation = Tween<double>(begin: 0, end: 0.1)
        .chain(CurveTween(curve: Curves.elasticInOut))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to trigger the swing animation
  void _swing() {
    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    // Access ProfileViewModel to retrieve user details
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final profile = profileViewModel.profile;

    // Screen width for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamic profile image size and font sizes
    double profileSize;
    double messageFontSize;
    double userNameFontSize;

    if (screenWidth < 600) {
      profileSize = 50.0;
      messageFontSize = 18.0;
      userNameFontSize = 24.0;
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      profileSize = 70.0;
      messageFontSize = 20.0;
      userNameFontSize = 28.0;
    } else {
      profileSize = 90.0;
      messageFontSize = 22.0;
      userNameFontSize = 32.0;
    }

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Trigger the swing animation when swiping horizontally
        if (details.delta.dx.abs() > 10) {
          _swing();
        }
      },
      child: AnimatedBuilder(
        animation: _swingAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _swingAnimation.value,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: profileSize / 2,
                backgroundImage: NetworkImage(profile.profileImageUrl),
                backgroundColor: Colors.grey[300],
                onBackgroundImageError: (exception, stackTrace) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
              const SizedBox(width: 16.0),
              // Welcome Message and User Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${profile.userName} 👋',
                      style: TextStyle(
                        fontSize: userNameFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: messageFontSize,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(profileScreen);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
