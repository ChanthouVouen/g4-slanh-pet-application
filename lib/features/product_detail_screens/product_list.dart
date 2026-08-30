import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/services/product/product_service.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';

import 'models/product_models.dart';
import 'product_detail.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  static const int _tabIndex = 1;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF3EE),
      appBar: AppBar(title: const Text('Products')),
      body: StreamBuilder<List<Product>>(
        stream: _productService.streamProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load products.'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;
          if (products.isEmpty) {
            return const Center(child: Text('No products yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                _ProductListTile(product: products[index]),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: ProductListScreen._tabIndex,
        onTap: (index) => switchBottomNavTab(
          context,
          currentIndex: ProductListScreen._tabIndex,
          index: index,
        ),
      ),
    );
  }
}

class _ProductListTile extends StatelessWidget {
  const _ProductListTile({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => ProductDetailScreen(productId: product.id),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 56,
                height: 56,
                child: product.image.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: product.bannerColors),
                        ),
                      )
                    : Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: product.bannerColors,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.formattedPrice,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.subtitleGray,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.subtitleGray,
            ),
          ],
        ),
      ),
    );
  }
}
