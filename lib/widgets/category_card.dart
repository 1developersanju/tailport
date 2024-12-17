import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailport/model/category.dart';
import 'package:tailport/view_model/home_viewmodel.dart';

class FloatingCategoryTabs extends StatefulWidget {
  const FloatingCategoryTabs({Key? key}) : super(key: key);

  @override
  _FloatingCategoryTabsState createState() => _FloatingCategoryTabsState();
}

class _FloatingCategoryTabsState extends State<FloatingCategoryTabs> {
  late Category _selectedCategory; // Selected category now defaults to "All"
  String _selectedSubcategory = '';

  @override
  void initState() {
    super.initState();
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    // Initialize "All" as the selected category
    _selectedCategory = homeViewModel.categories.firstWhere(
      (category) => category.name == 'All',
      orElse: () => homeViewModel.categories[0],
    );
    homeViewModel.updateSelectedCategory(_selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final categories = homeViewModel.categories;

    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: categories.map((category) {
            bool isSelected = _selectedCategory == category;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                
                label: Text(category.name),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _selectedCategory = selected ? category : _selectedCategory;
                    _selectedSubcategory = '';
                  });
                  homeViewModel.updateSelectedCategory(_selectedCategory);
                },
                selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
