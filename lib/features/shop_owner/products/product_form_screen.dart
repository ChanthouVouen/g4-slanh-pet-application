import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/state/shop_product_form_store.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/core/models/commerce/product.dart';
import 'package:slanh_pet_application/features/user_profile/widgets/edit_profile_widgets.dart';

/// Create/edit form for a shop's own product. Pass [product] to edit an
/// existing one, or omit it to create a new one.
class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key, this.product});

  final Product? product;

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ShopProductFormStore _formStore;

  @override
  void initState() {
    super.initState();
    _formStore = ShopProductFormStore(product: widget.product);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await _formStore.save();

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not save product: $error')));
    }
  }

  @override
  void dispose() {
    _formStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _formStore,
      builder: (context, _) => Scaffold(
        backgroundColor: const Color(0xFFFFF8F4),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFF8F4),
          elevation: 0,
          title: Text(_formStore.isEditing ? 'Edit Product' : 'Add Product'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              ProfileField(
                label: 'Product name',
                controller: _formStore.nameController,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter a product name'
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 7),
                    DropdownButtonFormField<String>(
                      initialValue: _formStore.type,
                      onChanged: (value) {
                        if (value != null) {
                          _formStore.setType(value);
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF3EEEB),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: [
                        for (final category in shopProductCategories)
                          DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              ProfileField(
                label: 'Price (\$)',
                controller: _formStore.priceController,
                validator: (value) {
                  final parsed = double.tryParse((value ?? '').trim());
                  if (parsed == null || parsed < 0) {
                    return 'Enter a valid price';
                  }
                  return null;
                },
              ),
              ProfileField(
                label: 'Stock',
                controller: _formStore.stockController,
                validator: (value) {
                  final parsed = int.tryParse((value ?? '').trim());
                  if (parsed == null || parsed < 0) {
                    return 'Enter a valid stock count';
                  }
                  return null;
                },
              ),
              ProfileField(
                label: 'Image URL',
                controller: _formStore.imageController,
              ),
              ProfileField(
                label: 'Description',
                controller: _formStore.descriptionController,
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              AuthSubmitButton(
                label: _formStore.isEditing ? 'Save Changes' : 'Add Product',
                isSubmitting: _formStore.isSaving,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
