import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import '../models/product_models.dart';
import 'badge_and_price.dart';
import 'product_tab_bar.dart';
import 'quantity_stepper.dart';
import 'rating_row.dart';
import 'store_row.dart';
import 'tab_content.dart';
import 'trust_badges_row.dart';

const _tabs = ['Details', 'Nutrition', 'Reviews'];

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.selectedTabIndex,
    required this.onTabSelected,
    required this.onIncrementQuantity,
    required this.onDecrementQuantity,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  final Product product;
  final int quantity;
  final int selectedTabIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onIncrementQuantity;
  final VoidCallback onDecrementQuantity;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BadgeAndPrice(product: product),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          RatingRow(product: product),
          const SizedBox(height: 14),
          StoreRow(product: product),
          const SizedBox(height: 18),
          ProductTabBar(
            tabs: _tabs,
            selectedIndex: selectedTabIndex,
            onSelected: onTabSelected,
          ),
          const SizedBox(height: 18),
          TabContent(product: product, tabIndex: selectedTabIndex),
          const SizedBox(height: 20),
          Row(
            children: [
              QuantityStepper(
                quantity: quantity,
                onDecrement: onDecrementQuantity,
                onIncrement: onIncrementQuantity,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: onAddToCart,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.orange,
                    side: const BorderSide(color: AppColors.orange),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onBuyNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Divider(height: 1, color: AppColors.borderLight),
          const SizedBox(height: 16),
          const TrustBadgesRow(),
        ],
      ),
    );
  }
}
