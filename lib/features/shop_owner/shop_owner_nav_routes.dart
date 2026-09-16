import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';

import 'dashboard/shop_owner_dashboard.dart';
import 'orders/shop_orders_screen.dart';
import 'products/shop_products_screen.dart';
import 'settings/shop_settings_screen.dart';

Widget _buildDashboard(BuildContext context) => const ShopOwnerDashboard();
Widget _buildProducts(BuildContext context) => const ShopProductsScreen();
Widget _buildOrders(BuildContext context) => const ShopOrdersScreen();
Widget _buildSettings(BuildContext context) => const ShopSettingsScreen();

const Map<int, WidgetBuilder> kShopOwnerNavScreenBuilders = {
  0: _buildDashboard,
  1: _buildProducts,
  2: _buildOrders,
  3: _buildSettings,
};

const shopOwnerNavItems = <NavBarItemData>[
  NavBarItemData(icon: Icons.dashboard_outlined, label: 'Dashboard'),
  NavBarItemData(icon: Icons.inventory_2_outlined, label: 'Products'),
  NavBarItemData(icon: Icons.receipt_long_outlined, label: 'Orders'),
  NavBarItemData(icon: Icons.storefront_outlined, label: 'Shop'),
];

void switchShopOwnerTab(
  BuildContext context, {
  required int currentIndex,
  required int index,
}) {
  if (index == currentIndex) return;

  final builder = kShopOwnerNavScreenBuilders[index];
  if (builder == null) return;

  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: builder));
}
