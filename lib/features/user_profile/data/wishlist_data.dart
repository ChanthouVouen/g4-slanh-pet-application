import '../models/wishlist_model.dart';

Future<List<WishlistModel>> getWishlistData() async {
  return const [
    WishlistModel(
      name: 'Hills Science Diet Adult Dog',
      price: 'RM 142.00',
      imageUrl:
          'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=600',
    ),
    WishlistModel(
      name: 'Catit Pixi Smart Fountain',
      price: 'RM 89.00',
      imageUrl:
          'https://images.unsplash.com/photo-1519052537078-e6302a4968d4?w=600',
    ),
    WishlistModel(
      name: 'Kong Classic Dog Toy XL',
      price: 'RM 58.90',
      imageUrl:
          'https://images.unsplash.com/photo-1552053831-71594a27632d?w=600',
    ),
    WishlistModel(
      name: 'PetSafe Walk Harness L',
      price: 'RM 82.00',
      imageUrl:
          'https://images.unsplash.com/photo-1558788353-f76d92427f16?w=600',
    ),
  ];
}
