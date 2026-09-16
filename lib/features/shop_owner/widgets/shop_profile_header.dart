import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/models/commerce/shop.dart';

class ShopProfileHeader extends StatelessWidget {
  const ShopProfileHeader({
    super.key,
    required this.shop,
    required this.isOpen,
    required this.onOpenChanged,
  });

  final Shop shop;
  final bool isOpen;
  final ValueChanged<bool> onOpenChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF8A5B), Color(0xFFFF6338)],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: Transform.translate(
            offset: const Offset(0, -28),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFFFFE0D3),
                    backgroundImage: shop.image.isNotEmpty
                        ? NetworkImage(shop.image)
                        : null,
                    child: shop.image.isEmpty
                        ? const Icon(Icons.storefront, color: AppColors.orange)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.name.isEmpty ? 'Your Shop' : shop.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          shop.tagline.isEmpty
                              ? 'Add a tagline below'
                              : shop.tagline,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Text(
                        isOpen ? 'Open' : 'Closed',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      Switch(
                        value: isOpen,
                        activeThumbColor: const Color(0xFF3DA35D),
                        onChanged: onOpenChanged,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
