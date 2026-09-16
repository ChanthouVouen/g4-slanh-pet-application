import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/models/commerce/product.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/services/product/product_service.dart';
import 'package:slanh_pet_application/core/state/cart_store.dart';
import 'package:slanh_pet_application/core/utility/ui_helper.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';

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
  late final Future<Product?> _productFuture = _productService.getProduct(
    widget.productId,
  );

  int _quantity = 1;
  int _selectedTab = 0;
  bool _isFavorite = false;

  void _incrementQuantity(Product product) {
    if (_quantity >= product.stock) {
      UiHelpers.showSnackBar(
        context,
        'Only ${product.stock} in stock.',
        isError: true,
      );
      return;
    }
    setState(() => _quantity++);
  }

  void _decrementQuantity() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  void _addToCart(Product product) {
    final added = CartStore.instance.addItem(
      product.name,
      product.price,
      shopId: product.shopId,
      maxStock: product.stock,
      productId: product.id,
      quantity: _quantity,
    );
    UiHelpers.showSnackBar(
      context,
      added
          ? 'Added $_quantity x ${product.name} to cart.'
          : 'Only ${product.stock} in stock. Check your cart quantity.',
      isError: !added,
    );
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
            if (product.stock <= 0) {
              return const Center(child: Text('This product is out of stock.'));
            }

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                ProductImageCarousel(
                  colors: product.bannerColors,
                  images: product.images,
                  isFavorite: _isFavorite,
                  onBack: () => Navigator.of(context).maybePop(),
                  onToggleFavorite: () => setState(
                    () => _isFavorite = !_isFavorite,
                  ),
                ),
                ProductCard(
                  product: product,
                  quantity: _quantity,
                  selectedTabIndex: _selectedTab,
                  onTabSelected: (index) => setState(() => _selectedTab = index),
                  onIncrementQuantity: () => _incrementQuantity(product),
                  onDecrementQuantity: _decrementQuantity,
                  onAddToCart: () => _addToCart(product),
                  onBuyNow: () => _addToCart(product),
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
