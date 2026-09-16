import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:slanh_pet_application/core/services/orders/shop_order_service.dart';
import 'package:slanh_pet_application/core/models/orders/shop_order.dart';
import '../widgets/order_card.dart';
import '../widgets/shop_owner_scaffold.dart';

class ShopOrdersScreen extends StatefulWidget {
  const ShopOrdersScreen({super.key});

  @override
  State<ShopOrdersScreen> createState() => _ShopOrdersScreenState();
}

class _ShopOrdersScreenState extends State<ShopOrdersScreen> {
  static const int _tabIndex = 2;

  late final Future<List<ShopOrder>> _ordersFuture = _loadOrders();

  Future<List<ShopOrder>> _loadOrders() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Future.value(const []);
    return ShopOrderService().fetchOrdersForShop(uid);
  }

  @override
  Widget build(BuildContext context) {
    return ShopOwnerScaffold(
      title: 'Orders',
      currentIndex: _tabIndex,
      body: FutureBuilder<List<ShopOrder>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load orders.'));
          }

          final orders = snapshot.data ?? const <ShopOrder>[];
          if (orders.isEmpty) {
            return const Center(
              child: Text('No orders yet for your shop\'s products.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                ShopOrderCard(order: orders[index]),
          );
        },
      ),
    );
  }
}
