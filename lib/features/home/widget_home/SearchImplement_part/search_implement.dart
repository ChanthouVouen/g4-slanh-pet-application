import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/cart/cart_screen.dart';
import 'package:slanh_pet_application/features/cart/cart_store.dart';
import 'package:slanh_pet_application/features/home/widget_home/SearchImplement_part/searching_page.dart';
import 'package:slanh_pet_application/features/home/widget_home/data_users/user_name.dart';

// import 'package:slanh_pet_application/main.dart';

class SearchImplement extends StatelessWidget {
  const SearchImplement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 205,
      color: const Color(0xFFF77F5A),
      child: Column(
        children: [
          const SizedBox(height: 28),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.symmetric(horizontal: 6),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back🙏🏻",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    UserName(),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _HeaderActionButton(
                      icon: Icons.chat_bubble_outline,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    _HeaderActionButton(
                      icon: Icons.notifications_none,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    ValueListenableBuilder<List<CartProduct>>(
                      valueListenable: CartStore.instance.itemsNotifier,
                      builder: (context, items, _) {
                        return _HeaderActionButton(
                          icon: Icons.shopping_cart_outlined,
                          badge: CartStore.instance.itemCount,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchingPage()),
              );
            },
            child: Container(
              width: double.infinity,
              height: 45,
              margin: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                  const Text(
                    "Search pet, products, services...",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 15,
                    ),
                    const Text(
                      "Petaling Jaya, MY",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text(
                  " 📦2 orders in transit",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    required this.onTap,
    this.badge = 0,
  });

  final IconData icon;
  final VoidCallback onTap;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.22),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          if (badge > 0)
            Positioned(
              top: -5,
              right: -5,
              child: Container(
                width: 17,
                height: 17,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$badge',
                  style: const TextStyle(
                    color: Color(0xFFF05D3A),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
