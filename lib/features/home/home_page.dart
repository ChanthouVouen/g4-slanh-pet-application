import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/features/cart/cart_screen.dart';
import 'package:slanh_pet_application/core/state/cart_store.dart';
import 'package:slanh_pet_application/features/home/widget_home/AdoptPet_part/adopt_banner.dart';
import 'package:slanh_pet_application/features/home/widget_home/Community_part/community_part.dart';
import 'package:slanh_pet_application/features/home/widget_home/Discount_part/discount_banner.dart';
import 'package:slanh_pet_application/features/home/widget_home/Popular_product_part/popular_product_part.dart';
import 'package:slanh_pet_application/features/home/widget_home/QuickService_part/quickService_part.dart';
import 'package:slanh_pet_application/features/home/widget_home/SearchImplement_part/search_implement.dart';
import 'package:slanh_pet_application/features/home/widget_home/data_users/user_name.dart';
import 'package:slanh_pet_application/features/home/widget_home/shopByPet_part/shopby_pet_part.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF77F5A),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome Back🙏🏻",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 2),
            UserName(),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ValueListenableBuilder<List<CartProduct>>(
              valueListenable: CartStore.instance.itemsNotifier,
              builder: (context, items, _) {
                return HeaderActionButton(
                  icon: Icons.shopping_cart_outlined,
                  badge: CartStore.instance.itemCount,
                  onTap: () => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const CartScreen())),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 243, 243),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Column(
            children: [
              SearchImplement(),
              DiscountBanner(),
              QuickservicePart(),
              ShopbyPetPart(),
              PopularProductPart(),
              AdoptBanner(),
              CommunityPart(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _tabIndex,
        onTap: (index) {
          switchBottomNavTab(context, currentIndex: _tabIndex, index: index);
        },
      ),
    );
  }
}
