import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/services/shop/shop_service.dart';

import '../models/product_models.dart';
import '../models/shop_model.dart';
import 'store_row_content.dart';
import 'store_row_skeleton.dart';


class StoreRow extends StatefulWidget {
  const StoreRow({super.key, required this.product});

  final Product product;

  @override
  State<StoreRow> createState() => _StoreRowState();
}

class _StoreRowState extends State<StoreRow> {
  final ShopService _shopService = ShopService();
  late Future<Shop?> _shopFuture;

  @override
  void initState() {
    super.initState();
    _shopFuture = _shopService.getShop(widget.product.shopId);
  }

  @override
  void didUpdateWidget(StoreRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.product.shopId != widget.product.shopId) {
      _shopFuture = _shopService.getShop(widget.product.shopId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Shop?>(
      future: _shopFuture,
      builder: (context, snapshot) {
        final shop = snapshot.data;
        if (shop != null) return StoreRowContent(shop: shop);


        if (snapshot.connectionState != ConnectionState.done) {
          return const StoreRowSkeleton(reason: null);
        }

        final String reason;
        if (snapshot.hasError) {
          reason = 'shops/${widget.product.shopId} failed: ${snapshot.error}';
        } else if (widget.product.shopId.isEmpty) {
          reason =
              'product ${widget.product.id} has no "shopid" field '
              '(all lowercase)';
        } else {
          reason = 'no document at shops/${widget.product.shopId}';
        }
        debugPrint('StoreRow: $reason');
        return StoreRowSkeleton(reason: reason);
      },
    );
  }
}
