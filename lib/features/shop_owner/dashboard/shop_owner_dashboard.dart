import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/services/shop/shop_service.dart';
import 'package:slanh_pet_application/core/models/commerce/shop.dart';

import '../shop_owner_nav_routes.dart';
import '../widgets/dashboard_widgets.dart';
import '../widgets/shop_owner_scaffold.dart';

class ShopOwnerDashboard extends StatelessWidget {
  const ShopOwnerDashboard({super.key});

  static const int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return ShopOwnerScaffold(
      title: 'My Shop',
      currentIndex: tabIndex,
      titleWidget: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SHOP OWNER',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.labelGray,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            'My Shop',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ],
      ),
      body: uid == null
          ? const Center(child: Text('No user is signed in.'))
          : StreamBuilder<Shop?>(
              stream: ShopService().watchShop(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final shop = snapshot.data;

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ShopInfoCard(shop: shop),
                    const SizedBox(height: 20),
                    const Text(
                      'QUICK ACTIONS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.labelGray,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ShopQuickActions(
                      onManageProducts: () => switchShopOwnerTab(
                        context,
                        currentIndex: tabIndex,
                        index: 1,
                      ),
                      onViewOrders: () => switchShopOwnerTab(
                        context,
                        currentIndex: tabIndex,
                        index: 2,
                      ),
                      onShopSettings: () => switchShopOwnerTab(
                        context,
                        currentIndex: tabIndex,
                        index: 3,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
