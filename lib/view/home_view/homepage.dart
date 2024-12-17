// lib/views/home_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailport/view/home_view/recent_listings.dart';
import 'package:tailport/view_model/home_viewmodel.dart';
import 'package:tailport/widgets/pet_card.dart';
import 'package:tailport/widgets/vertical_listing.dart';
import 'package:tailport/widgets/welcome_banner.dart';
import 'package:tailport/widgets/search_bar.dart';
import 'package:tailport/widgets/questionnaire_card.dart';
import 'package:tailport/widgets/category_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final pets = homeViewModel.filteredPets;

    return Scaffold(
      // backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Banner
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: WelcomeBanner(
                          message: 'Welcome to Tailport!',
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // Questionnaire Card
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: QuestionnaireCard(
                          title: 'Customize Your Experience',
                          description:
                              'Answer a few questions to tailor pet recommendations just for you.',
                          imageUrl:
                              'https://cdn.iconscout.com/icon/free/png-512/free-question-and-answer-icon-download-in-svg-png-gif-file-formats--questionnaire-qa-query-support-business-pack-icons-1269119.png?f=webp&w=256',
                          onTap: () {
                            // Show preference questionnaire logic
                          },
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // Search Bar
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomSearchBar(),
                      ),

                      const SizedBox(height: 16.0),

                      // Floating Category Tabs
                      const FloatingCategoryTabs(),

                      const SizedBox(height: 16.0),

                      // Recommended Pets Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Recommended for You',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // Recommended Pets List (Horizontally Scrollable)
                      SizedBox(
                        height: screenHeight * 0.4, // Constrained height
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeViewModel.filteredPets.length,
                          itemBuilder: (context, index) {
                            final pet = homeViewModel.filteredPets[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 16.0 : 8.0,
                                right: index ==
                                        homeViewModel.filteredPets.length - 1
                                    ? 16.0
                                    : 0.0,
                              ),
                              child: PetCard(
                                pet: pet,
                                width: screenWidth * 0.7, // 70% of screen width
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // Recent Listings Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Recent Listings',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // Recent Listings (Horizontally Scrollable)
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: homeViewModel.filteredPets.map((pet) {
                            return PetCardVertical(pet: pet);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
