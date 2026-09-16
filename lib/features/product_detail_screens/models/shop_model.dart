/// A seller's store, stored as one document in the `shops` collection under
/// the owner's uid (`shops/{uid}`). Products reference it by `shopid` instead
/// of copying these fields, so a rename or a new rating shows up everywhere
/// at once.
class Shop {
  const Shop({
    required this.id,
    required this.image,
    required this.name,
    required this.rating,
    required this.followers,
  });

  final String id;
  final String image;
  final String name;
  final double rating;
  final String followers;

  factory Shop.fromJson(Map<String, dynamic> json, String docId) {
    return Shop(
      id: docId,
      image: json['image']?.toString() ?? '',
      // Registration writes `shopName`; `name` is accepted for shops created
      // by hand from the Firebase console.
      name: json['shopName']?.toString() ?? json['name']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      followers: json['followers']?.toString() ?? '0',
    );
  }
}
