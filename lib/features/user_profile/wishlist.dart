import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/utility/ui_helper.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/core/models/commerce/wishlist_item.dart';
import 'package:slanh_pet_application/core/state/cart_store.dart';
import 'package:slanh_pet_application/core/state/wishlist_store.dart';
import 'package:slanh_pet_application/features/home/widget_home/Popular_product_part/popular_productcard.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  void _addToCart(BuildContext context, WishlistModel product) {
    CartStore.instance.addItem(product.name, product.price);
    UiHelpers.showSnackBar(context, 'Added ${product.name} to cart.');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<WishlistModel>>(
      valueListenable: WishlistStore.instance.itemsNotifier,
      builder: (context, wishlist, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFF8F4),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFF8F4),
            elevation: 0,
            leading: IconButton(
              tooltip: 'Back',
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            ),
            title: const Text(
              'Wishlist',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Center(
                  child: Text(
                    '${wishlist.length} items',
                    style: const TextStyle(
                      color: Color(0xFF858597),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: wishlist.isEmpty
              ? const Center(child: Text('Your wishlist is empty.'))
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: wishlist.length,
                  itemBuilder: (context, index) {
                    final product = wishlist[index];
                    return PopularProductCard(
                      image: product.imageUrl,
                      name: product.name,
                      rating: product.rating,
                      price: product.price,
                      onRemove: () =>
                          WishlistStore.instance.remove(product.name),
                      onAddToCart: () => _addToCart(context, product),
                    );
                  },
                ),
          bottomNavigationBar: const CustomBottomNavBar(
            currentIndex: 4,
            onTap: _ignoreNavigation,
          ),
        );
      },
    );
  }

  static void _ignoreNavigation(int index) {}
}
