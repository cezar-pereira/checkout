import 'package:checkout/app/core/domain/product_entity.dart';

import '../repositories/products_repository.dart';

abstract class AddProductStockUsecase {
  Future<void> call(ProductEntity product);
}

class AddProductStockUsecaseImp implements AddProductStockUsecase {
  final ProductsRepository repository;

  AddProductStockUsecaseImp({required this.repository});
  @override
  Future<void> call(ProductEntity product) async {
    await repository.addProductStock(product);
  }
}
