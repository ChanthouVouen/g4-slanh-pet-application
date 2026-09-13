import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/services/product/product_service.dart';
import 'package:slanh_pet_application/core/utility/ui_helper.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';

import 'models/product_models.dart';
import 'widget/product_card.dart';
import 'widget/product_image_carousel.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  static const int _tabIndex = -1;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _productService = ProductService();

  /// Built once, not inside build(): a future created during build would be
  /// re-issued on every setState, so changing the quantity or the tab would
  /// re-read the product and flash the loading spinner.
  late final Future<Product?> _productFuture = _productService.getProduct(
    widget.productId,
  );

  int _quantity = 1;
  int _selectedTab = 0;
  bool _isFavorite = false;

  void _incrementQuantity() => setState(() => _quantity++);

  void _decrementQuantity() {
    if (_quantity <= 1) return;
    setState(() => _quantity--);
  }

  void _toggleFavorite() => setState(() => _isFavorite = !_isFavorite);

  void _showComingSoon(String message) {
    UiHelpers.showSnackBar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF3EE),
      body: SafeArea(
        top: false,
        bottom: false,
        child: FutureBuilder<Product?>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Unable to load product.'));
            }

            final product = snapshot.data;
            if (product == null) {
              return const Center(child: Text('Product not found.'));
            }

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                ProductImageCarousel(
                  colors: product.bannerColors,
                  images: product.images,
                  isFavorite: _isFavorite,
                  onBack: () => Navigator.of(context).maybePop(),
                  onToggleFavorite: _toggleFavorite,
                ),
                ProductCard(
                  product: product,
                  quantity: _quantity,
                  selectedTabIndex: _selectedTab,
                  onTabSelected: (index) =>
                      setState(() => _selectedTab = index),
                  onIncrementQuantity: _incrementQuantity,
                  onDecrementQuantity: _decrementQuantity,
                  onAddToCart: () => _showComingSoon(
                    'Added $_quantity × ${product.name} to cart.',
                  ),
                  onBuyNow: () => _showComingSoon('Checkout coming soon.'),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: ProductDetailScreen._tabIndex,
        onTap: (index) => switchBottomNavTab(
          context,
          currentIndex: ProductDetailScreen._tabIndex,
          index: index,
        ),
      ),
    );
  }
}
