import 'package:firebase_auth/firebase_auth.dart';
import 'package:slanh_pet_application/core/models/commerce/product.dart';
import 'package:slanh_pet_application/core/services/product/product_service.dart';

class ShopProductStore {
  ShopProductStore({ProductService? productService})
    : _productService = productService ?? ProductService();

  final ProductService _productService;

  String? get shopId => FirebaseAuth.instance.currentUser?.uid;

  Stream<List<Product>> get products {
    final id = shopId;
    return id == null
        ? const Stream<List<Product>>.empty()
        : _productService.streamShopProducts(id);
  }

  Future<void> delete(Product product) {
    return _productService.deleteProduct(product.id);
  }
}
