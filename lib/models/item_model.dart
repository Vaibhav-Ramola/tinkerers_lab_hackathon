class Item {
  final String name;
  final String description;
  final String category;
  final String imageUrl;
  final String id;
  bool isFavourite;

  Item({
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.id,
    required this.isFavourite,
  });
}
