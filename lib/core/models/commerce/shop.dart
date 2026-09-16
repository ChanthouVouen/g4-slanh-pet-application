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
    this.tagline = '',
    this.phone = '',
    this.email = '',
    this.address = '',
    this.isOpen = true,
  });

  final String id;
  final String image;
  final String name;
  final double rating;
  final String followers;
  final String tagline;
  final String phone;
  final String email;
  final String address;
  final bool isOpen;

  factory Shop.fromJson(Map<String, dynamic> json, String docId) {
    return Shop(
      id: docId,
      image: json['image']?.toString() ?? '',
      // Registration writes `shopName`; `name` is accepted for shops created
      // by hand from the Firebase console.
      name: json['shopName']?.toString() ?? json['name']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      followers: json['followers']?.toString() ?? '0',
      tagline: json['tagline']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      // Registration writes `shopAddress`; `address` is accepted for shops
      // edited from the shop owner's settings screen.
      address:
          json['shopAddress']?.toString() ?? json['address']?.toString() ?? '',
      isOpen: json['isOpen'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'shopName': name,
      'tagline': tagline,
      'phone': phone,
      'email': email,
      'shopAddress': address,
      'isOpen': isOpen,
      if (image.isNotEmpty) 'image': image,
    };
  }
}
