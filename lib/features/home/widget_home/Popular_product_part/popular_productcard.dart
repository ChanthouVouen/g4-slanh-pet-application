import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/utility/ui_helper.dart';
import 'package:slanh_pet_application/features/user_profile/models/wishlist_model.dart';
import 'package:slanh_pet_application/features/user_profile/wishlist_store.dart';

class PopularProductCard extends StatefulWidget {
  final String image;
  final String name;
  final double rating;
  final double price;
  final VoidCallback? onAddToCart;

  /// When set, the top-right button removes the item (e.g. from a
  /// wishlist) instead of toggling favorite.
  final VoidCallback? onRemove;

  const PopularProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.price,
    this.onAddToCart,
    this.onRemove,
  });

  @override
  State<PopularProductCard> createState() => _PopularProductCardState();
}

class _PopularProductCardState extends State<PopularProductCard> {
  /// Wishlist toggling only applies to plain product cards; a card already
  /// showing an [onRemove] button (e.g. inside the Wishlist screen itself)
  /// doesn't need its own favorite state.
  bool get _isWishlistable => widget.onRemove == null;

  void _toggleWishlist() {
    WishlistStore.instance.toggle(
      WishlistModel(
        name: widget.name,
        price: widget.price,
        imageUrl: widget.image,
        rating: widget.rating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isWishlistable) {
      return ValueListenableBuilder<List<WishlistModel>>(
        valueListenable: WishlistStore.instance.itemsNotifier,
        builder: (context, _, _) => _buildCard(
          isFavorite: WishlistStore.instance.isWishlisted(widget.name),
        ),
      );
    }
    return _buildCard(isFavorite: false);
  }

  Widget _buildCard({required bool isFavorite}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 2,
            color: Colors.black12,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // =========================
          // IMAGE
          // =========================
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),

                  child: Image.network(
                    widget.image,

                    width: double.infinity,
                    height: double.infinity,

                    fit: BoxFit.cover,

                    // Optional loading indicator
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const Center(child: CircularProgressIndicator());
                    },

                    // Optional error image
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.image_not_supported, size: 40),
                      );
                    },
                  ),
                ),

                // =========================
                // FAVORITE BUTTON
                // =========================
                Positioned(
                  top: 10,
                  right: 10,

                  child: GestureDetector(
                    onTap: () {
                      if (widget.onRemove != null) {
                        widget.onRemove!();
                        return;
                      }
                      _toggleWishlist();
                    },

                    child: Container(
                      width: 40,
                      height: 40,

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),

                      child: widget.onRemove != null
                          ? const Icon(
                              Icons.close,
                              color: Colors.black54,
                              size: 20,
                            )
                          : Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.black54,
                              size: 24,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // =========================
          // TITLE
          // =========================
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),

            child: Text(
              widget.name[0].toUpperCase() + widget.name.substring(1),

              maxLines: 1,

              overflow: TextOverflow.ellipsis,

              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
          ),

          // Rating
          Container(
            padding: EdgeInsets.only(left: 8, top: 0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  size: 19,
                  color: const Color.fromARGB(255, 243, 222, 33),
                ),
                Text(
                  widget.rating.toStringAsFixed(1),

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // =========================
          // PRICE + ADD TO CART
          // =========================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    '\$${widget.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    if (widget.onAddToCart != null) {
                      widget.onAddToCart!();
                    } else {
                      UiHelpers.showSnackBar(
                        context,
                        'Added ${widget.name} to cart.',
                      );
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6633),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 17),
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
