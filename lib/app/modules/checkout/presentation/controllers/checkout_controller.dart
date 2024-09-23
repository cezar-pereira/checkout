import 'package:checkout/app/core/domain/product_entity.dart';
import 'package:checkout/app/core/domain/promotion.dart';
import 'package:checkout/app/modules/products/domain/usecases/fetch_products_stock_usecase.dart';
import 'package:checkout/app/modules/promotions/domain/usecases/fetch_promotions_usecase.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/checkout_entity.dart';

enum CheckoutControllerState { loading, success, error }

class CheckoutController extends ChangeNotifier {
  final FetchProductsStockUsecase fetchProductsStockUsecase;
  final FetchPromotionsUsecase fetchPromotionsUsecase;

  CheckoutController({required this.fetchProductsStockUsecase, required this.fetchPromotionsUsecase}) {
    onInit();
  }

  final CheckoutEntity checkout = CheckoutEntity();
  CheckoutControllerState state = CheckoutControllerState.loading;

  List<ProductEntity> _productStock = [];
  List<ProductEntity> get productStock => _productStock;

  Future<void> onInit() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // to test
      state = CheckoutControllerState.loading;
      _productStock = await _fetchProducts();
      final promotions = await _fetchPromotions();
      checkout.addPromotions(promotions);
      state = CheckoutControllerState.success;
    } catch (e) {
      state = CheckoutControllerState.error;
    }
    notifyListeners();
  }

  Future<List<ProductEntity>> _fetchProducts() async {
    try {
      return await fetchProductsStockUsecase();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Promotion>> _fetchPromotions() async {
    try {
      return await fetchPromotionsUsecase();
    } catch (e) {
      rethrow;
    }
  }

  void addProduct(ProductEntity product) {
    checkout.scanProduct(product);
    checkout.calcTotal();
    notifyListeners();
  }
}
