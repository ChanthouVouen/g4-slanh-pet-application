import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/models/commerce/product.dart';

class ProductRow extends StatelessWidget {
  const ProductRow({
    super.key,
    required this.product,
    required this.onTap,
    required this.onDelete,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  bool get _isOutOfStock => product.stock <= 0;

  ({String label, Color color}) get _stockBadge {
    if (_isOutOfStock) {
      return (label: 'Out of Stock', color: const Color(0xFFE5484D));
    }
    if (product.stock <= 10) {
      return (label: 'Low', color: const Color(0xFFE8A33D));
    }
    return (label: '${product.stock} Left', color: const Color(0xFF3DA35D));
  }

  Widget _thumbnail() {
    final image = Image.network(
      product.image,
      width: 52,
      height: 52,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: 52,
        height: 52,
        color: AppColors.inputBackground,
        child: const Icon(Icons.pets, color: AppColors.labelGray),
      ),
    );

    if (!_isOutOfStock) return image;
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
      child: Opacity(opacity: 0.5, child: image),
    );
  }

  @override
  Widget build(BuildContext context) {
    final badge = _stockBadge;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: _isOutOfStock
            ? Border.all(color: badge.color.withValues(alpha: 0.4))
            : null,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _thumbnail(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _isOutOfStock ? AppColors.labelGray : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.type.isEmpty ? 'Uncategorized' : product.type,
                    style: const TextStyle(
                      color: AppColors.labelGray,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: badge.color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    child: Text(
                      badge.label,
                      style: TextStyle(
                        color: badge.color,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: onDelete,
              tooltip: 'Delete product',
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.labelGray,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
