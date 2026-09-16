import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/models/commerce/product.dart';
import 'package:slanh_pet_application/core/services/product/product_service.dart';

const shopProductCategories = ['Food', 'Toy', 'Accessories', 'Pets'];

class ShopProductFormStore extends ChangeNotifier {
  ShopProductFormStore({this.product, ProductService? productService})
    : _productService = productService ?? ProductService(),
      nameController = TextEditingController(text: product?.name ?? ''),
      priceController = TextEditingController(
        text: product == null ? '' : product.price.toStringAsFixed(2),
      ),
      stockController = TextEditingController(
        text: product == null ? '' : product.stock.toString(),
      ),
      imageController = TextEditingController(text: product?.image ?? ''),
      descriptionController = TextEditingController(
        text: product?.description ?? '',
      ),
      _type = product?.type.isNotEmpty == true
          ? product!.type
          : shopProductCategories.first;

  final Product? product;
  final ProductService _productService;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController stockController;
  final TextEditingController imageController;
  final TextEditingController descriptionController;

  String _type;
  bool _saving = false;

  bool get isEditing => product != null;
  String get type => _type;
  bool get isSaving => _saving;

  void setType(String value) {
    _type = value;
    notifyListeners();
  }

  Future<void> save() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw StateError('No user is signed in.');

    _saving = true;
    notifyListeners();

    try {
      final price = double.parse(priceController.text.trim());
      final stock = int.parse(stockController.text.trim());
      final image = imageController.text.trim();

      if (isEditing) {
        await _productService.updateProduct(
          product!.copyWith(
            name: nameController.text.trim(),
            price: price,
            image: image,
            description: descriptionController.text.trim(),
            type: _type,
            stock: stock,
          ),
        );
      } else {
        await _productService.createProduct(
          Product(
            id: '',
            name: nameController.text.trim(),
            badge: '',
            price: price,
            originalPrice: price,
            rating: 0,
            soldCount: 0,
            reviewCount: 0,
            shopId: uid,
            description: descriptionController.text.trim(),
            details: const [],
            nutrition: const [],
            bannerColors: const [AppColors.orange],
            image: image,
            images: image.isEmpty ? const [] : [image],
            type: _type,
            stock: stock,
          ),
        );
      }
    } finally {
      _saving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    imageController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
