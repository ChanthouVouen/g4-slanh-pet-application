import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/services/fireStore_service/firestore_service.dart';
import 'package:slanh_pet_application/core/widgets/firestore_stream_builder.dart';
import 'package:slanh_pet_application/features/home/widget_home/Popular_product_part/popular_productcard.dart';

class ProductPart extends StatelessWidget {
  final String selectedCategory;
  final String searchQuery;

  const ProductPart({
    super.key,
    required this.selectedCategory,
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    final bool isSearching = searchQuery.trim().isNotEmpty;

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              FirestoreStreamBuilder(
                stream: isSearching
                    ? FirestoreService().searchProducts(searchQuery)
                    : FirestoreService().getProductsByType(selectedCategory),

                builder: (products) {
                  // Check if no products were found
                  if (products.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(30),
                      child: Center(
                        child: Text(
                          isSearching
                              ? 'No products found for "${searchQuery.trim()}"'
                              : 'No products found',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }

                  // Display products when products exist
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
                        image: data['image'] ?? '',
                        name: data['name'] ?? 'No Name',
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
