import 'package:flutter/foundation.dart';

class CartProduct {
  final String name;
  final double price;
  int quantity;
  final String? shopId;
  final int? maxStock;
  final String? productId;

  CartProduct({
    required this.name,
    required this.price,
    this.quantity = 1,
    this.shopId,
    this.maxStock,
    this.productId,
  });
}

class CartStore {
  CartStore._();

  static final CartStore instance = CartStore._();

  final ValueNotifier<List<CartProduct>> itemsNotifier = ValueNotifier([]);

  List<CartProduct> get items => itemsNotifier.value;

  int get itemCount => items.fold<int>(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      items.fold<double>(0, (sum, item) => sum + (item.price * item.quantity));

  bool addItem(
    String name,
    double price, {
    String? shopId,
    int? maxStock,
    String? productId,
    int quantity = 1,
  }) {
    if (quantity <= 0) return false;

    final existingIndex = items.indexWhere((item) => item.name == name);

    if (existingIndex >= 0) {
      final existing = items[existingIndex];
      final limit = existing.maxStock;
      if (limit != null && existing.quantity + quantity > limit) return false;

      final updated = [...items];
      updated[existingIndex].quantity += quantity;
      itemsNotifier.value = updated;
      return true;
    }

    if (maxStock != null && (maxStock <= 0 || quantity > maxStock)) {
      return false;
    }

    itemsNotifier.value = [
      ...items,
      CartProduct(
        name: name,
        price: price,
        quantity: quantity,
        shopId: shopId,
        maxStock: maxStock,
        productId: productId,
      ),
    ];
    return true;
  }

  bool increaseQuantity(String name) {
    final updated = [...items];
    final index = updated.indexWhere((item) => item.name == name);
    if (index < 0) return false;

    final item = updated[index];
    if (item.maxStock != null && item.quantity >= item.maxStock!) {
      return false;
    }

    item.quantity += 1;
    itemsNotifier.value = updated;
    return true;
  }

  void decreaseQuantity(String name) {
    final updated = [...items];
    final index = updated.indexWhere((item) => item.name == name);
    if (index < 0) return;

    if (updated[index].quantity <= 1) {
      updated.removeAt(index);
    } else {
      updated[index].quantity -= 1;
    }

    itemsNotifier.value = updated;
  }

  void clear() {
    itemsNotifier.value = [];
  }
}
