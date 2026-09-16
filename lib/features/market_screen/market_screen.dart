import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/features/cart/cart_screen.dart';
import 'package:slanh_pet_application/features/cart/cart_store.dart';
import 'package:slanh_pet_application/features/market_screen/widget/appbar_screen.dart';
import 'package:slanh_pet_application/features/market_screen/widget/categories_part/categories_screen.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_part.dart';
import 'package:slanh_pet_application/features/market_screen/widget/products_part/products_part.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  static const int tabIndex = 1;

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  String selectedCategory = "All";

  void _addToCart(String productName, double price) {
    CartStore.instance.addItem(productName, price);
  }

  void _openCartScreen(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const CartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),

          ValueListenableBuilder<List<CartProduct>>(
            valueListenable: CartStore.instance.itemsNotifier,
            builder: (context, items, child) {
              final currentCartCount = items.fold<int>(
                0,
                (total, item) => total + item.quantity,
              );

              return AppBarScreen(
                cartCount: currentCartCount,
                onCartTap: () => _openCartScreen(context),
              );
            },
          ),

          // CATEGORY
          CategoriesScreen(
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),

          FilterPart(selectedCategory: selectedCategory),

          const SizedBox(height: 10),

          ProductPart(
            selectedCategory: selectedCategory,
            onAddToCart: (productName, price) => _addToCart(productName, price),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: MarketScreen.tabIndex,
        onTap: (index) {
          switchBottomNavTab(
            context,
            currentIndex: MarketScreen.tabIndex,
            index: index,
          );
        },
      ),
    );
  }
}
