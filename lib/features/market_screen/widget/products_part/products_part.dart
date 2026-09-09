import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/services/fireStore_service/firestore_service.dart';
import 'package:slanh_pet_application/core/widgets/firestore_stream_builder.dart';
import 'package:slanh_pet_application/features/home/widget_home/Popular_product_part/popular_productcard.dart';

class ProductPart extends StatelessWidget {
  final String selectedCategory;

  const ProductPart({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              FirestoreStreamBuilder(
                stream: FirestoreService().getProductsByType(selectedCategory),

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
                          childAspectRatio: 0.72,
                        ),

                    itemCount: products.length,

                    itemBuilder: (context, index) {
                      final product = products[index];

                      final data = product.data();

                      return PopularProductCard(
                        image: data['image'] ?? "",
                        name: data['name'] ?? "No Name",
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
