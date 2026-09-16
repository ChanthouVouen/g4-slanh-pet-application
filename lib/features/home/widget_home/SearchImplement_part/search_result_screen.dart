import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/services/fireStore_service/firestore_service.dart';
import 'package:slanh_pet_application/core/widgets/firestore_stream_builder.dart';
import 'package:slanh_pet_application/features/home/widget_home/Popular_product_part/popular_productcard.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchQuery;

  const SearchResultScreen({super.key, required this.searchQuery});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late TextEditingController searchController;
  late String currentSearchQuery;

  @override
  void initState() {
    super.initState();

    currentSearchQuery = widget.searchQuery;

    searchController = TextEditingController(text: currentSearchQuery);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchProducts() {
    final query = searchController.text.trim();

    if (query.isEmpty) return;

    setState(() {
      currentSearchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F5),

      body: SafeArea(
        child: Column(
          children: [
            // Back button and search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: const Icon(Icons.arrow_back, size: 26),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F1EF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextField(
                        controller: searchController,

                        // Press Enter/Search to search again
                        onSubmitted: (value) {
                          searchProducts();
                        },

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          hintText: "Search products...",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Search result products
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: FirestoreStreamBuilder(
                    stream: FirestoreService().searchProducts(
                      currentSearchQuery,
                    ),

                    builder: (allProducts) {
                      // Hide products the shop has explicitly marked out of
                      // stock; a missing `stock` field means it isn't
                      // tracked, so keep showing it.
                      final products = allProducts.where((doc) {
                        final stock = doc.data()['stock'];
                        return stock == null || (stock as num).toInt() > 0;
                      }).toList();

                      if (products.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(30),
                          child: Center(
                            child: Text(
                              'No products found for "$currentSearchQuery"',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }

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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
