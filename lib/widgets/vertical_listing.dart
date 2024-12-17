import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/pet.dart';

class VerticalPetListing extends StatelessWidget {
  final List<Pet> pets;

  const VerticalPetListing({Key? key, required this.pets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/pet-details', arguments: pet);
              },
              child: Row(
                children: [
                  // Pet Image
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(16.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: pet.imageUrl,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),

                  // Pet Details
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pet Name
                          Text(
                            pet.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4.0),
                          // Breed and Age
                          Text(
                            '${pet.breed}, ${pet.age} years old',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8.0),
                          // Giver Priority
                          if (pet.giverPriority == 'sale')
                            Text(
                              '\$${pet.price?.toStringAsFixed(2) ?? ''}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Action Button
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/${pet.giverPriority}-details',
                            arguments: pet);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pet.giverPriority == 'adoption'
                            ? Colors.green
                            : Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        pet.giverPriority == 'adoption' ? 'Adopt' : 'Buy',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
