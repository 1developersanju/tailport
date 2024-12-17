import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tailport/utils/appcolors.dart';
import '../utils/styles.dart';
import '../model/pet.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final double width; // Dynamic width for responsiveness

  const PetCard({Key? key, required this.pet, this.width = 200})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imageHeight = width * 0.6; // Maintain a 3:2 aspect ratio
    final double cardPadding = width * 0.04; // Dynamic padding
    final double fontSize = width < 300 ? 14.0 : 16.0;

    // Button and action logic based on giverPriority
    String buttonLabel;
    Widget actionWidget;

    if (pet.giverPriority == 'adoption') {
      buttonLabel = 'Adopt';
      actionWidget = ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/adoption-details', arguments: pet);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPurple, // Themed color
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2.0,
        ),
        child: Text(
          buttonLabel,
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      );
    } else if (pet.giverPriority == 'sale') {
      buttonLabel = 'Buy';
      actionWidget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Buy Button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/purchase-details',
                    arguments: pet);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple, // Themed color
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 3.0,
              ),
              child: Text(
                buttonLabel,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          // Price Tag
          Expanded(
            child: Text(
              '₹${pet.price?.toStringAsFixed(2) ?? 'N/A'}',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: fontSize + 2,
                fontWeight: FontWeight.bold,
                color: AppColors.darkCharcoal,
              ),
            ),
          ),
        ],
      );
    } else {
      buttonLabel = 'Unavailable';
      actionWidget = ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.warmGrey,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(buttonLabel),
      );
    }

    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: cardPadding / 2),
      decoration: AppStyles.cardDecoration.copyWith(
        color: AppColors.softYellow, // Card background
        boxShadow: [
          BoxShadow(
            color: AppColors.veryLightPink.withOpacity(0.3),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pet Image
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: CachedNetworkImage(
              imageUrl: pet.imageUrl,
              height: imageHeight,
              width: width,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: imageHeight,
                width: width,
                color: AppColors.lightPinkSecondary,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: imageHeight,
                width: width,
                color: AppColors.lightPinkSecondary,
                child: const Icon(Icons.error, color: AppColors.pink),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          // Tags: Age and Breed
          Padding(
            padding: EdgeInsets.symmetric(horizontal: cardPadding),
            child: Wrap(
              spacing: 8.0,
              children: [
                Chip(

                  label: Text(
                    '${pet.age} years old',
                    style: TextStyle(fontSize: fontSize - 2),
                  ),
                  backgroundColor: AppColors.lightPink.withOpacity(0.3),
                  
                ),
                Chip(
                  label: Text(
                    pet.breed,
                    style: TextStyle(fontSize: fontSize - 2),
                  ),
                  backgroundColor: AppColors.lightPinkSecondary.withOpacity(0.3),
                ),
              ],
            ),
          ),
          // Pet Details and Action Button
          Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: fontSize + 2,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkCharcoal,
                      ),
                ),
                const SizedBox(height: 12.0),
                actionWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
