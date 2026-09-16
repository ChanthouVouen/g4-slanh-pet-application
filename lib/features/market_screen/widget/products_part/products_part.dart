import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/services/fireStore_service/firestore_service.dart';
import 'package:slanh_pet_application/core/utility/ui_helper.dart';
import 'package:slanh_pet_application/core/widgets/firestore_stream_builder.dart';
import 'package:slanh_pet_application/core/state/cart_store.dart';
import 'package:slanh_pet_application/features/home/widget_home/Popular_product_part/popular_productcard.dart';
import 'package:slanh_pet_application/features/product_detail_screens/product_detail.dart';

typedef AddToCartDetails = ({
  String productName,
  double price,
  String? shopId,
  int? stock,
  String? productId,
});

class ProductPart extends StatelessWidget {
  final String selectedCategory;
  final void Function(AddToCartDetails details)? onAddToCart;
  final String searchQuery;

  const ProductPart({
    super.key,
    required this.selectedCategory,
    required this.onAddToCart,
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

                builder: (allProducts) {
                  // Hide products the shop has explicitly marked out of
                  // stock; a missing `stock` field means it isn't tracked,
                  // so keep showing it (backward-compatible with older
                  // products that predate stock tracking).
                  final products = allProducts.where((doc) {
                    final stock = doc.data()['stock'];
                    return stock == null || (stock as num).toInt() > 0;
                  }).toList();

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
                    padding: const EdgeInsets.only(bottom: 24),
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
                      final productName = data['name'] ?? 'Product';
                      final productPrice =
                          (data['price'] as num?)?.toDouble() ?? 0.0;
                      final stock = (data['stock'] as num?)?.toInt();

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(productId: product.id),
                          ),
                        ),
                        child: PopularProductCard(
                          image: data['image'] ?? '',
                          name: productName,
                          rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
                          price: productPrice,
                          onAddToCart: () {
                            final shopId = data['shopid'] as String?;
                            if (onAddToCart != null) {
                              onAddToCart!((
                                productName: productName,
                                price: productPrice,
                                shopId: shopId,
                                stock: stock,
                                productId: product.id,
                              ));
                            } else {
                              final added = CartStore.instance.addItem(
                                productName,
                                productPrice,
                                shopId: shopId,
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
        ),
      ),
    );
  }
}
