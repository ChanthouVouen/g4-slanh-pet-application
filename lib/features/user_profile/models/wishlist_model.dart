class WishlistModel {
  const WishlistModel({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.rating = 0.0,
  });

  final String name;
  final double price;
  final String imageUrl;
  final double rating;
}
