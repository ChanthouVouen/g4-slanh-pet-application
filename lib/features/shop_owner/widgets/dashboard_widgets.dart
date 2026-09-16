import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/models/commerce/shop.dart';
import 'package:slanh_pet_application/core/widgets/section_card.dart';

class ShopInfoCard extends StatelessWidget {
  const ShopInfoCard({super.key, required this.shop});

  final Shop? shop;

  @override
  Widget build(BuildContext context) {
    final hasLogo = shop?.image.isNotEmpty == true;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A5B), Color(0xFFFF6338)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            backgroundImage: hasLogo ? NetworkImage(shop!.image) : null,
            child: hasLogo
                ? null
                : const Icon(Icons.storefront, color: AppColors.orange),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop == null || shop!.name.isEmpty ? 'Your Shop' : shop!.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (shop?.tagline.isNotEmpty == true) ...[
                  const SizedBox(height: 2),
                  Text(
                    shop!.tagline,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Text(
                      shop?.isOpen ?? true ? 'Open' : 'Closed',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShopQuickActions extends StatelessWidget {
  const ShopQuickActions({
    super.key,
    required this.onManageProducts,
    required this.onViewOrders,
    required this.onShopSettings,
  });

  final VoidCallback onManageProducts;
  final VoidCallback onViewOrders;
  final VoidCallback onShopSettings;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      children: [
        _QuickActionTile(
          icon: Icons.inventory_2_outlined,
          title: 'Manage Products',
          subtitle: 'Add, edit or remove products',
          onTap: onManageProducts,
        ),
        const Divider(height: 24),
        _QuickActionTile(
          icon: Icons.receipt_long_outlined,
          title: 'View Orders',
          subtitle: 'See orders for your shop',
          onTap: onViewOrders,
        ),
        const Divider(height: 24),
        _QuickActionTile(
          icon: Icons.storefront_outlined,
          title: 'Shop Settings',
          subtitle: 'Edit your shop information',
          onTap: onShopSettings,
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFFFF0E9),
            foregroundColor: AppColors.orange,
            child: Icon(icon, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.labelGray),
        ],
      ),
    );
  }
}
