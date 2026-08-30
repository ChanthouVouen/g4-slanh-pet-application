import 'package:flutter/material.dart';


typedef ProductSpec = ({String label, String value});


typedef ProductStore = ({String name, double rating, String followers});

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
    required this.store,
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
  final ProductStore store;
  final String description;
  final List<ProductSpec> details;
  final List<ProductSpec> nutrition;
  final String image;
  final List<String> images;


  final List<Color> bannerColors;

  String get formattedPrice => 'RM ${price.toStringAsFixed(2)}';
  String get formattedOriginalPrice => 'RM ${originalPrice.toStringAsFixed(2)}';


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
      images: images.isNotEmpty
          ? images
          : (image.isEmpty ? <String>[] : [image]),


      store: (
        name: json['store']?['name'] ?? '',
        rating: (json['store']?['rating'] ?? 0.0).toDouble(),
        followers: json['store']?['followers'] ?? '',
      ),
      
      description: json['description'] ?? '',
      

      details: List<ProductSpec>.from(
        (json['details'] as List? ?? []).map((e) => (label: e['label'] ?? '', value: e['value'] ?? '')),
      ),
      
      nutrition: List<ProductSpec>.from(
        (json['nutrition'] as List? ?? []).map((e) => (label: e['label'] ?? '', value: e['value'] ?? '')),
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

      'store': {
        'name': store.name,
        'rating': store.rating,
        'followers': store.followers,
      },
      
      'description': description,
      

      'details': details.map((e) => {'label': e.label, 'value': e.value}).toList(),
      'nutrition': nutrition.map((e) => {'label': e.label, 'value': e.value}).toList(),
      

      'bannerColors': bannerColors.map((e) => e.value).toList(),
    };
  }
}
