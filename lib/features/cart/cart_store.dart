import 'package:flutter/foundation.dart';

class CartProduct {
  final String name;
  final double price;
  int quantity;

  CartProduct({required this.name, required this.price, this.quantity = 1});
}

class CartStore {
  CartStore._();

  static final CartStore instance = CartStore._();

  final ValueNotifier<List<CartProduct>> itemsNotifier = ValueNotifier([]);

  List<CartProduct> get items => itemsNotifier.value;

  int get itemCount => items.fold<int>(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      items.fold<double>(0, (sum, item) => sum + (item.price * item.quantity));

  void addItem(String name, double price) {
    final existingIndex = items.indexWhere((item) => item.name == name);

    if (existingIndex >= 0) {
      final updated = [...items];
      updated[existingIndex].quantity += 1;
      itemsNotifier.value = updated;
      return;
    }

    itemsNotifier.value = [
      ...items,
      CartProduct(name: name, price: price, quantity: 1),
    ];
  }

  void increaseQuantity(String name) {
    final updated = [...items];
    final index = updated.indexWhere((item) => item.name == name);
    if (index >= 0) {
      updated[index].quantity += 1;
      itemsNotifier.value = updated;
    }
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
