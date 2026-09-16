class ShopOrderItem {
  const ShopOrderItem({
    required this.name,
    required this.price,
    required this.quantity,
  });

  final String name;
  final double price;
  final int quantity;
}

/// One customer order, narrowed down to just the items that belong to a
/// single shop (a customer's cart can span multiple shops).
class ShopOrder {
  const ShopOrder({
    required this.id,
    required this.orderRef,
    required this.customerName,
    required this.createdAt,
    required this.status,
    required this.items,
  });

  final String id;
  final String orderRef;
  final String customerName;
  final DateTime? createdAt;
  final String status;
  final List<ShopOrderItem> items;

  double get subtotal =>
      items.fold<double>(0, (sum, item) => sum + item.price * item.quantity);
}
