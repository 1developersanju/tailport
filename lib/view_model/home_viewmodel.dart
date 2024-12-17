// lib/viewmodels/home_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:tailport/model/category.dart';
import 'package:tailport/model/pet.dart';

class HomeViewModel extends ChangeNotifier {
  List<Pet> _allPets = [];
  List<Pet> _filteredPets = [];
  List<Category> _categories = [];

  String _selectedCategory = 'All';
  String _selectedSubcategory = '';

  List<Pet> get filteredPets => _filteredPets;
  List<Category> get categories => _categories;

  HomeViewModel() {
    // Initialize dummy data
    _initializeDummyCategories();
    _initializeDummyPets();
    applyFilters();
  }

  void _initializeDummyCategories() {
    _categories = [
      Category(name: 'All', subcategories: []),
      Category(
          name: 'Dogs', subcategories: ['Golden Retriever', 'Pug', 'Bulldog']),
      Category(
          name: 'Cats', subcategories: ['Siamese', 'Persian', 'Maine Coon']),
      Category(name: 'Birds', subcategories: ['Parrot', 'Canary', 'Finch']),
      Category(name: 'Reptiles', subcategories: ['Snake', 'Lizard', 'Turtle']),
    ];
    notifyListeners();
  }

  void _initializeDummyPets() {
    _allPets = [
      Pet(
        id: '1',
        name: 'Buddy',
        breed: 'Golden Retriever',
        age: 3,
        category: 'Dogs',
        subcategory: 'Golden Retriever',
        imageUrl:
            'https://images.unsplash.com/photo-1558788353-f76d92427f16?w=400&auto=format&fit=crop&q=60',
        giverPriority: 'adoption',
      ),
      Pet(
        id: '2',
        name: 'Mittens',
        breed: 'Siamese',
        age: 2,
        category: 'Cats',
        subcategory: 'Siamese',
        imageUrl:
            'https://images.unsplash.com/photo-1508927415581-538b97647924?w=400&auto=format&fit=crop&q=60',
        giverPriority: 'sale',
        price: 7900,
      ),
      Pet(
        id: '3',
        name: 'Polly',
        breed: 'Parrot',
        age: 1,
        category: 'Birds',
        subcategory: 'Parrot',
        imageUrl:
            'https://images.unsplash.com/photo-1452570053594-1b985d6ea890?w=400&auto=format&fit=crop&q=60',
        giverPriority: 'adoption',
      ),
      Pet(
        id: '4',
        name: 'Lizzy',
        breed: 'Lizard',
        age: 4,
        category: 'Reptiles',
        subcategory: 'Lizard',
        imageUrl:
            'https://images.unsplash.com/photo-1470165385455-e981fe780611?w=400&auto=format&fit=crop&q=60',
        giverPriority: 'sale',
        price: 5000,
      ),
      Pet(
        id: '5',
        name: 'Shadow',
        breed: 'Husky',
        age: 4,
        category: 'Dogs',
        subcategory: 'Husky',
        imageUrl:
            'https://images.unsplash.com/photo-1421098518790-5a14be02b243?w=400&auto=format&fit=crop&q=60',
        giverPriority: 'adoption',
      ),
      Pet(
        id: '6',
        name: 'Whiskers',
        breed: 'Persian',
        age: 3,
        category: 'Cats',
        subcategory: 'Persian',
        imageUrl:
            'https://images.unsplash.com/photo-1601102396652-79e10c02fc87?w=400&auto=format&fit=crop&q=60',
        giverPriority: 'sale',
        price: 250.00,
      ),
    ];
    notifyListeners();
  }

  void updateSelectedCategory(Category category) {
    _selectedCategory = category.name;
    _selectedSubcategory = '';
    applyFilters();
    notifyListeners();
  }

  void updateSelectedSubcategory(String categoryName, String subcategory) {
    if (_selectedCategory == categoryName) {
      _selectedSubcategory = subcategory;
      applyFilters();
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    // Implement search functionality if needed
    // For simplicity, this method can filter pets by name
    if (query.isEmpty) {
      applyFilters();
    } else {
      _filteredPets = _allPets
          .where((pet) => pet.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  void applyFilters() {
    _filteredPets = _allPets.where((pet) {
      bool matchesCategory =
          _selectedCategory == 'All' || pet.category == _selectedCategory;
      bool matchesSubcategory = _selectedSubcategory.isEmpty ||
          pet.subcategory == _selectedSubcategory;
      return matchesCategory && matchesSubcategory;
    }).toList();
  }
}
