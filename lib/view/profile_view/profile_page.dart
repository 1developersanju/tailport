import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailport/model/profile.dart';
import 'package:tailport/utils/appcolors.dart';
import 'package:tailport/view_model/profile_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final profile = profileViewModel.profile;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.warmOrange,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: AppColors.softBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header
              _buildProfileHeader(profile),

              const SizedBox(height: 24.0),

              // User Stats
              _buildStatsSection(profile),

              const SizedBox(height: 24.0),

              // User Actions
              _buildActionsSection(context, profileViewModel),

              const SizedBox(height: 24.0),

              // Settings Section
              _buildSettingsSection(context, profileViewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Profile profile) {
    return Card(
      color: AppColors.lightBeige,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(profile.profileImageUrl),
              backgroundColor: AppColors.mutedCoral,
            ),
            const SizedBox(width: 16.0),
            // Name and Email
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.userName,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    profile.email,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColors.warmGrey,
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

  Widget _buildStatsSection(Profile profile) {
    return Card(
      color: AppColors.lightBeige,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(Icons.pets, 'Pets Sold', profile.petsSold,
                AppColors.warmOrange),
            _buildStatItem(Icons.favorite, 'Pets Adopted', profile.petsAdopted,
                AppColors.softPink),
            _buildStatItem(Icons.store, 'For Sale', profile.petsForSale,
                AppColors.softYellow),
            _buildStatItem(Icons.volunteer_activism, 'For Adoption',
                profile.petsForAdoption, AppColors.lightPurple),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      IconData icon, String label, int value, Color iconColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, size: 30.0, color: iconColor),
        ),
        const SizedBox(height: 8.0),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: AppColors.darkCharcoal,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: const TextStyle(fontSize: 14.0, color: AppColors.warmGrey),
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context, ProfileViewModel viewModel) {
    final profile = viewModel.profile;

    return Column(
      children: [
        if (profile.isAuthorizedSeller)
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to add pet for sale or adoption
            },
            icon: const Icon(Icons.add, size: 20.0),
            label: const Text('Add Pet for Sale or Adoption'),
            style: ElevatedButton.styleFrom(

              backgroundColor: AppColors.mutedCoral,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 14.0,horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          )
        else
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to become an authorized seller
            },
            icon: const Icon(Icons.star, size: 20.0),
            label: const Text('Become an Authorized Seller'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.softYellow,
              foregroundColor: AppColors.darkCharcoal,
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSettingsSection(
      BuildContext context, ProfileViewModel viewModel) {
    final profile = viewModel.profile;

    return Card(
      color: AppColors.lightBeige,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.language, color: AppColors.mutedCoral),
            title: const Text('Preferred Language'),
            subtitle: Text(
              profile.preferredLanguage,
              style: const TextStyle(color: AppColors.softBlack),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
            onTap: () {
              // Handle language selection
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.color_lens, color: AppColors.softPink),
            title: const Text('Theme'),
            subtitle: Text(
              profile.theme,
              style: const TextStyle(color: AppColors.softBlack),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
            onTap: () {
              viewModel.toggleTheme();
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.location_on, color: AppColors.lightPurple),
            title: const Text('Address'),
            subtitle: Text(
              profile.address,
              style: const TextStyle(color: AppColors.softBlack),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
            onTap: () {
              // Navigate to address update page
            },
          ),
        ],
      ),
    );
  }
}
