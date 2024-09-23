import 'dart:convert';

import 'package:checkout/app/core/domain/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/product_entity.dart';
import '../../../core/failures/product_already_exist_failure.dart';

sealed class ProductsDatasource {
  Future<List<ProductEntity>> fetchProductsStock();
  Future<void> addProductStock(ProductEntity product);
  Future<void> removeProductStock(ProductEntity product);
}

class ProductsDatasourceImp extends ProductsDatasource {
  @override
  Future<void> addProductStock(ProductEntity product) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = await fetchProductsStock();

    if (currentList.contains(product)) throw ProductAlreadyExistFailure();

    currentList.add(product);

    List<String> stringList = currentList.map((map) => jsonEncode(map.toJson())).toList();

    await prefs.setStringList('products', stringList);
  }

  @override
  Future<List<ProductEntity>> fetchProductsStock() async {
    final prefs = await SharedPreferences.getInstance();

    final products = prefs.getStringList('products');

    if (products == null) return [];

    return products.map((e) => ProductModel.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> removeProductStock(ProductEntity product) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = await fetchProductsStock();

    currentList.removeWhere((e) => e.sku == product.sku);

    List<String> stringList = currentList.map((map) => jsonEncode(map.toJson())).toList();

    await prefs.setStringList('products', stringList);
  }
}
