// lib/widgets/questionnaire_card.dart

import 'package:flutter/material.dart';
import '../utils/styles.dart';

class QuestionnaireCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const QuestionnaireCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine profile image size based on screen type
    double imageSize;
    double fontSizeTitle;
    double fontSizeDesc;

    if (screenWidth < 600) {
      imageSize = 60.0;
      fontSizeTitle = 18.0;
      fontSizeDesc = 14.0;
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      imageSize = 80.0;
      fontSizeTitle = 20.0;
      fontSizeDesc = 16.0;
    } else {
      imageSize = 100.0;
      fontSizeTitle = 24.0;
      fontSizeDesc = 18.0;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
              Theme.of(context).colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Decorative Image/Icon
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.white, width: 2.0),
              ),

            ),
            const SizedBox(width: 20.0),
            // Textual Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSizeTitle,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: fontSizeDesc,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  // Action Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: ()=>onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Start Questionnaire',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
