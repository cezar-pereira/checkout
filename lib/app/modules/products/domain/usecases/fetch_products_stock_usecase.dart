import 'package:checkout/app/core/domain/product_entity.dart';

import '../repositories/products_repository.dart';

abstract class FetchProductsStockUsecase {
  Future<List<ProductEntity>> call();
}

class FetchProductsStockUsecaseImp implements FetchProductsStockUsecase {
  final ProductsRepository repository;

  FetchProductsStockUsecaseImp({required this.repository});
  @override
  Future<List<ProductEntity>> call() async {
    return await repository.fetchProductsStock();
  }
}
