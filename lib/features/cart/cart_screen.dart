import 'package:flutter/material.dart';

import 'cart_store.dart';
import 'checkout_screen.dart';
import 'widgets/cart_item_tile.dart';
import 'widgets/cart_summary_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _openCheckout(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const CheckoutScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CartStore.instance.itemsNotifier,
      builder: (context, _) {
        final items = CartStore.instance.items;
        final total = CartStore.instance.totalPrice;

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Cart'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          body: items.isEmpty
              ? const Center(
                  child: Text(
                    'Your cart is empty.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return CartItemTile(
                              item: item,
                              onIncrement: () => CartStore.instance
                                  .increaseQuantity(item.name),
                              onDecrement: () => CartStore.instance
                                  .decreaseQuantity(item.name),
                            );
                          },
                        ),
                      ),
                      CartSummaryBar(
                        total: total,
                        onCheckout: () => _openCheckout(context),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
