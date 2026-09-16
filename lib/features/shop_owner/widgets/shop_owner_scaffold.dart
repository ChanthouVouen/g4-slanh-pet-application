import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';

import '../shop_owner_nav_routes.dart';

class ShopOwnerScaffold extends StatelessWidget {
  const ShopOwnerScaffold({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.body,
    this.titleWidget,
  });

  final String title;
  final int currentIndex;
  final Widget body;
  final Widget? titleWidget;

  static const backgroundColor = Color(0xFFFFF8F4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title:
            titleWidget ??
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
      ),
      body: body,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        items: shopOwnerNavItems,
        onTap: (index) => switchShopOwnerTab(
          context,
          currentIndex: currentIndex,
          index: index,
        ),
      ),
    );
  }
}
