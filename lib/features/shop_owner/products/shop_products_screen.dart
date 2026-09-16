import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/models/commerce/product.dart';
import 'package:slanh_pet_application/core/state/shop_product_store.dart';

import 'product_form_screen.dart';
import '../widgets/product_row.dart';
import '../widgets/shop_owner_scaffold.dart';

class ShopProductsScreen extends StatefulWidget {
  const ShopProductsScreen({super.key});

  @override
  State<ShopProductsScreen> createState() => _ShopProductsScreenState();
}

class _ShopProductsScreenState extends State<ShopProductsScreen> {
  static const int _tabIndex = 1;

  final _productStore = ShopProductStore();

  Future<void> _openForm(BuildContext context, {Product? product}) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductFormScreen(product: product),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Product product) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete product?'),
        content: Text('"${product.name}" will be removed permanently.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) await _productStore.delete(product);
  }

  @override
  Widget build(BuildContext context) {
    return ShopOwnerScaffold(
      title: 'Products',
      currentIndex: _tabIndex,
      body: _productStore.shopId == null
          ? const Center(child: Text('No user is signed in.'))
          : StreamBuilder<List<Product>>(
              stream: _productStore.products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = snapshot.data ?? const <Product>[];

                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    for (final product in products)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ProductRow(
                          product: product,
                          onTap: () => _openForm(context, product: product),
                          onDelete: () => _confirmDelete(context, product),
                        ),
                      ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _openForm(context),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Product'),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
