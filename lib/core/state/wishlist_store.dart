import 'package:flutter/foundation.dart';

import '../models/commerce/wishlist_item.dart';

class WishlistStore {
  WishlistStore._();

  static final WishlistStore instance = WishlistStore._();

  final ValueNotifier<List<WishlistModel>> itemsNotifier = ValueNotifier([]);

  List<WishlistModel> get items => itemsNotifier.value;

  bool isWishlisted(String name) => items.any((item) => item.name == name);

  void add(WishlistModel product) {
    if (isWishlisted(product.name)) return;
    itemsNotifier.value = [...items, product];
  }

  void remove(String name) {
    itemsNotifier.value = items.where((item) => item.name != name).toList();
  }

  void toggle(WishlistModel product) {
    if (isWishlisted(product.name)) {
      remove(product.name);
    } else {
      add(product);
    }
  }
}
