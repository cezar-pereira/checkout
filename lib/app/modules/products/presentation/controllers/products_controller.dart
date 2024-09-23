import 'package:checkout/app/app_widget.dart';
import 'package:checkout/app/core/domain/product_entity.dart';

import 'package:flutter/material.dart';

import '../../../../core/failures/product_already_exist_failure.dart';
import '../../domain/usecases/add_product_stock_usecase.dart';
import '../../domain/usecases/fetch_products_stock_usecase.dart';

class ProductsController extends ChangeNotifier {
  final FetchProductsStockUsecase fetchProductsStockUsecase;
  final AddProductStockUsecase addProductStockUsecase;

  List<ProductEntity> productStock = [];

  ProductsController({required this.fetchProductsStockUsecase, required this.addProductStockUsecase}) {
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final result = await fetchProductsStockUsecase();
      productStock = result;
    } catch (e) {
      //TODO tratar possíveis erros
    }
    notifyListeners();
  }

  Future<void> addProduct(ProductEntity product) async {
    try {
      await addProductStockUsecase(product);
      _fetchProducts();
    } on ProductAlreadyExistFailure catch (e) {
      if (scaffoldMessengerKey.currentContext != null) {
        scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(e.messageError)));
      }
    } catch (e) {
      //TODO tratar possíveis erros
    }
    notifyListeners();
  }
}
