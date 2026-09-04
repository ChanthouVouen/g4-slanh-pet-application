import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/services/fireStore_service/firestore_service.dart';
import 'package:slanh_pet_application/core/widgets/firestore_stream_builder.dart';
import 'package:slanh_pet_application/features/home/widget_home/Popular_product_part/popular_productcard.dart';
import 'package:slanh_pet_application/features/market_screen/market_screen.dart';

class PopularProductPart extends StatelessWidget {
  const PopularProductPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: const Text(
                    'Popular Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202033),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MarketScreen()),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        'See all',
                        style: TextStyle(
                          color: Color(0xFFFF6633),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xFFFF6633),
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // PRODUCT GRID
          // PRODUCT GRID
          FirestoreStreamBuilder(
            stream: FirestoreService().getCollection('products'),
            builder: (products) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                padding: EdgeInsets.zero,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                  // Makes the card taller
                  childAspectRatio: 0.72,
                ),

                itemCount: 4,

                itemBuilder: (context, index) {
                  final product = products[index];

                  final data = product.data();

                  return PopularProductCard(
                    image: data['image'] ?? "",
                    name: data['name'] ?? "no Name",
                    rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
                    price: (data['price'] as num?)?.toDouble() ?? 0.0,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// final products = [
//   {'image': 'assets/images/dog1.jpg', 'title': 'Dog', 'price': 90.0},
//   {'image': 'assets/images/bird1.jpg', 'title': 'Bird', 'price': 40.0},
//   {'image': 'assets/images/cat1.jpg', 'title': 'Cat', 'price': 60.0},
//   {'image': 'assets/images/dog2.jpg', 'title': 'Dog', 'price': 80.0},
// ];
