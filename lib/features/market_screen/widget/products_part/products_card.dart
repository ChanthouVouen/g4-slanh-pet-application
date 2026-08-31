import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String image;
  final String name;
  final double rating;
  final double price;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.price,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
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
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },

                    child: Container(
                      width: 40,
                      height: 40,

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),

                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,

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
                  "${widget.rating.toStringAsFixed(1)}",

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
          // PRICE
          // =========================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

            child: Text(
              '\$${widget.price.toStringAsFixed(2)}',

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
