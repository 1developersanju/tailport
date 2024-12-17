// lib/model/profile.dart

class Profile {
  final String userName;
  final String profileImageUrl;
  final String contactNumber;
  final String email;
  final bool isAuthorizedSeller;
  final int petsSold;
  final int petsAdopted;
  final int petsForSale;
  final int petsForAdoption;
  final String preferredLanguage;
  final String theme; // light or dark
  final String address;

  Profile({
    required this.userName,
    required this.profileImageUrl,
    required this.contactNumber,
    required this.email,
    this.isAuthorizedSeller = false,
    this.petsSold = 0,
    this.petsAdopted = 0,
    this.petsForSale = 0,
    this.petsForAdoption = 0,
    this.preferredLanguage = 'English',
    this.theme = 'Light',
    this.address = '',
  });
}
