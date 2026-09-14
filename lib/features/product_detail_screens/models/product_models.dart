import 'package:flutter/material.dart';

typedef ProductSpec = ({String label, String value});

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.badge,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.soldCount,
    required this.reviewCount,
    required this.shopId,
    required this.description,
    required this.details,
    required this.nutrition,
    required this.bannerColors,
    required this.image,
    required this.images,
  });

  final String id;
  final String name;
  final String badge;
  final double price;
  final double originalPrice;
  final double rating;
  final int soldCount;
  final int reviewCount;

  /// References the owning seller's document in the `shops` collection
  /// (`shops/{shopId}`). The shop's name, logo, rating and follower count are
  /// read from there, never copied into the product document.
  final String shopId;
  final String description;
  final List<ProductSpec> details;
  final List<ProductSpec> nutrition;
  final String image;
  final List<String> images;

  final List<Color> bannerColors;

  String get formattedPrice => '\$ ${price.toStringAsFixed(2)}';
  String get formattedOriginalPrice => '\$ ${originalPrice.toStringAsFixed(2)}';

  factory Product.fromJson(Map<String, dynamic> json, String docId) {
    final image = json['image'] ?? '';
    final images = List<String>.from(
      (json['images'] as List? ?? []).map((e) => e.toString()),
    );

    return Product(
      id: docId,
      name: json['name'] ?? '',
      badge: json['badge'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      soldCount: json['soldCount'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      image: image,
      images: images,
      shopId: json['shopid'] ?? '',
      description: json['description'] ?? '',
      // Both `details` and `nutrition` are stored as a single-element array
      // holding a map of arbitrary label -> value pairs (e.g.
      // `[{Flavor: "Chicken & Rice", Weight: "15 Kg"}]`), not `{label,
      // value}` entries.
      details: List<ProductSpec>.from(
        (json['details'] as List? ?? [])
            .whereType<Map>()
            .expand((map) => map.entries)
            .map((e) => (label: e.key.toString(), value: e.value.toString())),
      ),
      nutrition: List<ProductSpec>.from(
        (json['nutrition'] as List? ?? [])
            .whereType<Map>()
            .expand((map) => map.entries)
            .map((e) => (label: e.key.toString(), value: e.value.toString())),
      ),

      bannerColors: List<Color>.from(
        (json['bannerColors'] as List? ?? []).map((e) => Color(e as int)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'badge': badge,
      'price': price,
      'originalPrice': originalPrice,
      'rating': rating,
      'soldCount': soldCount,
      'reviewCount': reviewCount,
      'image': image,
      'images': images,
      'shopid': shopId,
      'description': description,
      'details': [
        {for (final e in details) e.label: e.value},
      ],
      'nutrition': [
        {for (final e in nutrition) e.label: e.value},
      ],
      'bannerColors': bannerColors.map((e) => e.toARGB32()).toList(),
    };
  }
}
