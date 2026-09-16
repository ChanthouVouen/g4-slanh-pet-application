import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/services/fireStore_service/firestore_service.dart';
import 'package:slanh_pet_application/core/utility/ui_helper.dart';
import 'package:slanh_pet_application/core/widgets/firestore_stream_builder.dart';
import 'package:slanh_pet_application/core/state/cart_store.dart';
import 'package:slanh_pet_application/features/home/widget_home/Popular_product_part/popular_productcard.dart';
import 'package:slanh_pet_application/features/product_detail_screens/product_detail.dart';
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
            builder: (allProducts) {
              // Hide products the shop has explicitly marked out of stock;
              // a missing `stock` field means it isn't tracked, so keep
              // showing it (backward-compatible with older products).
              final products = allProducts.where((doc) {
                final stock = doc.data()['stock'];
                return stock == null || (stock as num).toInt() > 0;
              }).toList();

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

                // Show at most 4, but never more than we actually have.
                itemCount: products.length < 4 ? products.length : 4,

                itemBuilder: (context, index) {
                  final product = products[index];

                  final data = product.data();

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(productId: product.id),
                      ),
                    ),
                    child: PopularProductCard(
                      image: data['image'] ?? "",
                      name: data['name'] ?? "no Name",
                      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
                      price: (data['price'] as num?)?.toDouble() ?? 0.0,
                      onAddToCart: () {
                        final stock = (data['stock'] as num?)?.toInt();
                        final added = CartStore.instance.addItem(
                          data['name'] ?? 'Product',
                          (data['price'] as num?)?.toDouble() ?? 0.0,
                          shopId: data['shopid'] as String?,
                          maxStock: stock,
                          productId: product.id,
                        );
                        if (!added) {
                          UiHelpers.showSnackBar(
                            context,
                            'Only $stock in stock.',
                            isError: true,
                          );
                        }
                      },
                    ),
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
