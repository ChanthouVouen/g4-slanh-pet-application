import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/services/fireStore_service/firestore_service.dart';
import 'package:slanh_pet_application/core/widgets/firestore_stream_builder.dart';
import 'package:slanh_pet_application/features/home/widget_home/Popular_product_part/popular_productcard.dart';

class ProductPart extends StatelessWidget {
  const ProductPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          // color: Colors.blue,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),

              // PRODUCT GRID
              FirestoreStreamBuilder(
                stream: FirestoreService().getCollection("products"),

                builder: (products) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    padding: EdgeInsets.zero,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,

                          // Makes the card taller
                          childAspectRatio: 0.72,
                        ),

                    itemCount: products.length,

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
        ),
      ),
    );
  }
}
