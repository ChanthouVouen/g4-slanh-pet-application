import 'payment_method.dart';

/// Snapshot of a placed cart order, shown on the order-confirmed screen.
class OrderSummary {
  const OrderSummary({
    required this.itemCount,
    required this.total,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.orderRef,
  });

  final int itemCount;
  final double total;
  final PaymentMethod paymentMethod;
  final String deliveryAddress;
  final String orderRef;

  String get itemsLabel => itemCount == 1 ? '1 item' : '$itemCount items';

  String get paymentMethodLabel => switch (paymentMethod) {
    PaymentMethod.khqr => 'KHQR Code',
    PaymentMethod.cashOnDelivery => 'Cash on Delivery',
  };

  String get formattedTotal => '\$${total.toStringAsFixed(2)}';
}
