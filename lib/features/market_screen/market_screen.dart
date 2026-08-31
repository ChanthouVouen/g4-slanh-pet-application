import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/features/market_screen/widget/appbar_screen.dart';
import 'package:slanh_pet_application/features/market_screen/widget/categories_part/categories_screen.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_part.dart';
import 'package:slanh_pet_application/features/market_screen/widget/products_part/products_part.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});
  static const int _tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),

          AppBarScreen(),

          CategoriesScreen(),

          FilterPart(),

          SizedBox(height: 10),

          ProductPart(),
        ],
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
