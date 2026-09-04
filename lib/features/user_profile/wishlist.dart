import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'data/wishlist_data.dart';
import 'models/wishlist_model.dart';
import 'widgets/wishlist_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late final Future<List<WishlistModel>> _wishlistData;

  @override
  void initState() {
    super.initState();
    _wishlistData = getWishlistData();
  }

  @override
  Widget build(BuildContext context) {
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                '4 items',
                style: TextStyle(color: Color(0xFF858597), fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<WishlistModel>>(
        future: _wishlistData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final products = snapshot.data ?? const <WishlistModel>[];
          if (products.isEmpty) {
            return const Center(child: Text('Your wishlist is empty.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 18,
              mainAxisExtent: 286,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => WishlistCard(
              product: products[index],
              onRemove: () {},
              onAddToCart: () {},
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 4,
        onTap: _ignoreNavigation,
      ),
    );
  }

  static void _ignoreNavigation(int index) {}
}
