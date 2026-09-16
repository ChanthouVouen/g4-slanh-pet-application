import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/utility/ui_helper.dart';

import 'package:slanh_pet_application/core/models/orders/delivery_address.dart';
import 'package:slanh_pet_application/core/models/orders/payment_method.dart';
import 'package:slanh_pet_application/core/services/orders/delivery_address_service.dart';
import 'package:slanh_pet_application/core/services/orders/product_order_service.dart';
import 'package:slanh_pet_application/core/state/cart_store.dart';
import 'models/order_summary.dart';
import 'order_confirmed_screen.dart';
import 'widgets/checkout/delivery_address_card.dart';
import 'widgets/checkout/edit_address_sheet.dart';
import 'widgets/checkout/order_items_card.dart';
import 'widgets/checkout/payment_method_card.dart';
import 'widgets/checkout/place_order_bar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color _background = Color(0xFFFBF3EE);

  final _addressService = DeliveryAddressService();
  final _orderService = ProductOrderService();

  DeliveryAddress _address = const DeliveryAddress();
  PaymentMethod _paymentMethod = PaymentMethod.khqr;
  bool _loadingAddress = true;
  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    final address = await _addressService.fetchCurrent();
    if (!mounted) return;
    setState(() {
      _address = address;
      _loadingAddress = false;
    });
  }

  Future<void> _openChangeAddressSheet() async {
    final updated = await showEditAddressSheet(context, _address);
    if (updated == null) return;

    setState(() => _address = updated);
    await _addressService.save(updated);
  }

  Future<void> _placeOrder(double total) async {
    if (_isPlacingOrder) return;

    if (!_address.isComplete) {
      UiHelpers.showSnackBar(
        context,
        'Please add a delivery address first.',
        isError: true,
      );
      await _openChangeAddressSheet();
      return;
    }

    if (FirebaseAuth.instance.currentUser == null) {
      UiHelpers.showSnackBar(
        context,
        'Please sign in to place an order.',
        isError: true,
      );
      return;
    }

    setState(() => _isPlacingOrder = true);

    final items = CartStore.instance.items;
    final itemCount = items.length;
    String? orderRef;
    String? failureMessage;
    try {
      orderRef = await _orderService.createOrder(
        items: items,
        total: total,
        paymentMethod: _paymentMethod,
        deliveryAddress: _address,
      );
    } on ProductUnavailableException catch (e) {
      debugPrint('CheckoutScreen._placeOrder: ${e.message}');
      failureMessage = e.message;
    } on FirebaseException catch (e) {
      debugPrint('CheckoutScreen._placeOrder: order creation failed: $e');
      failureMessage = e.code == 'permission-denied'
          ? 'Order permission was denied. Please contact support.'
          : 'Could not place your order: ${e.message ?? e.code}';
    } catch (e) {
      debugPrint('CheckoutScreen._placeOrder: order creation failed: $e');
      failureMessage = 'Could not place your order. Please try again.';
    }

    if (!mounted) return;

    if (orderRef == null) {
      setState(() => _isPlacingOrder = false);
      UiHelpers.showSnackBar(
        context,
        failureMessage ?? 'Could not place your order. Please try again.',
        isError: true,
      );
      return;
    }

    final summary = OrderSummary(
      itemCount: itemCount,
      total: total,
      paymentMethod: _paymentMethod,
      deliveryAddress: _address.address,
      orderRef: orderRef,
    );

    CartStore.instance.clear();
    setState(() => _isPlacingOrder = false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OrderConfirmedScreen(summary: summary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = CartStore.instance.items;
    final total = CartStore.instance.totalPrice;

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeliveryAddressCard(
              address: _address,
              loading: _loadingAddress,
              onChangeTap: _openChangeAddressSheet,
            ),
            const SizedBox(height: 16),
            OrderItemsCard(items: items, total: total),
            const SizedBox(height: 16),
            PaymentMethodCard(
              selected: _paymentMethod,
              onChanged: (method) => setState(() => _paymentMethod = method),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PlaceOrderBar(
        total: total,
        enabled: items.isNotEmpty,
        isSubmitting: _isPlacingOrder,
        onPressed: () => _placeOrder(total),
      ),
    );
  }
}
