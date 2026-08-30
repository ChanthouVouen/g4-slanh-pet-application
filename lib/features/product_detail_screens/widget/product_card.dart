import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import '../models/product_models.dart';
import 'product_tab_bar.dart';
import 'quantity_stepper.dart';
import 'spec_grid.dart';
import 'store_info_row.dart';
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
    required this.onStoreTap,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  final Product product;
  final int quantity;
  final int selectedTabIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onIncrementQuantity;
  final VoidCallback onDecrementQuantity;
  final VoidCallback onStoreTap;
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
          _BadgeAndPrice(product: product),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          _RatingRow(product: product),
          const SizedBox(height: 14),
          StoreInfoRow(store: product.store, onTap: onStoreTap),
          const SizedBox(height: 18),
          ProductTabBar(
            tabs: _tabs,
            selectedIndex: selectedTabIndex,
            onSelected: onTabSelected,
          ),
          const SizedBox(height: 18),
          _TabContent(product: product, tabIndex: selectedTabIndex),
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
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
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
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
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

class _BadgeAndPrice extends StatelessWidget {
  const _BadgeAndPrice({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.orange.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            product.badge,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: AppColors.orange,
            ),
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              product.formattedPrice,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.orange,
              ),
            ),
            Text(
              product.formattedOriginalPrice,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: AppColors.labelGray,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 17, color: Color(0xFFFFB800)),
        const SizedBox(width: 3),
        Text(
          '${product.rating}',
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 8),
        _Dot(),
        const SizedBox(width: 8),
        Text(
          '${_formatCount(product.soldCount)} sold',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.subtitleGray,
          ),
        ),
        const SizedBox(width: 8),
        _Dot(),
        const SizedBox(width: 8),
        Text(
          '${product.reviewCount} reviews',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.subtitleGray,
          ),
        ),
      ],
    );
  }

  static String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(count % 1000 == 0 ? 0 : 1)}k';
    }
    return count.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
        );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: 3,
      decoration: const BoxDecoration(
        color: AppColors.labelGray,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.product, required this.tabIndex});

  final Product product;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    switch (tabIndex) {
      case 1:
        return SpecGrid(specs: product.nutrition);
      case 2:
        return _ReviewsSummary(product: product);
      case 0:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            SpecGrid(specs: product.details),
          ],
        );
    }
  }
}

class _ReviewsSummary extends StatelessWidget {
  const _ReviewsSummary({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const Icon(Icons.star_rounded, size: 28, color: Color(0xFFFFB800)),
          const SizedBox(height: 6),
          Text(
            '${product.rating} out of 5',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            'Based on ${product.reviewCount} reviews',
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.subtitleGray,
            ),
          ),
        ],
      ),
    );
  }
}
