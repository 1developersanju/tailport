class Pet {
  final String id;
  final String name;
  final String breed;
  final int age;
  final String category;
  final String subcategory;
  final String imageUrl;
  final String giverPriority; // 'adoption' or 'sale'
  final double? price; // Nullable, only applicable for sale

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.category,
    required this.subcategory,
    required this.imageUrl,
    required this.giverPriority,
    this.price,
  });
}
