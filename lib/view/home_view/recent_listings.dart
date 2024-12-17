import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tailport/model/pet.dart';
import 'package:tailport/utils/appcolors.dart';

class PetCardVertical extends StatelessWidget {
  final Pet pet;

  const PetCardVertical({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.lightBeige,
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: pet.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.lightPinkSecondary.withOpacity(0.2),
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, color: AppColors.pink),
            ),
          ),
          const SizedBox(width: 16.0),

          // Pet Details Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pet Name
                Text(
                  pet.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkCharcoal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),

                // Tags for Age and Breed
                Row(
                  children: [
                    _buildTag('${pet.age} yrs'),
                    const SizedBox(width: 8.0),
                    _buildTag(pet.breed),
                  ],
                ),
                const SizedBox(height: 8.0),

                // Price and Action Button (Aligned Bottom)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Price (if applicable)
                    if (pet.giverPriority == 'sale')
                      Text(
                        '₹${pet.price?.toStringAsFixed(2) ?? ''}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.purple,
                        ),
                      ),
                    const Spacer(),

                    // Action Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          pet.giverPriority == 'adoption'
                              ? '/adoption-details'
                              : '/purchase-details',
                          arguments: pet,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pet.giverPriority == 'adoption'
                            ? AppColors.lightPurple
                            : AppColors.purple,
                        foregroundColor: AppColors.white,
                        elevation: 2.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        pet.giverPriority == 'adoption' ? 'Adopt' : 'Buy',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tag Widget
  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.lightPink.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.0,
          color: AppColors.darkCharcoal,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
