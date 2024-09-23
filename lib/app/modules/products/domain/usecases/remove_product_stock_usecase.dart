import 'package:checkout/app/core/domain/product_entity.dart';

import '../repositories/products_repository.dart';

abstract class RemoveProductStockUsecase {
  Future<void> call(ProductEntity product);
}

class RemoveProductStockUsecaseImp implements RemoveProductStockUsecase {
  final ProductsRepository repository;

  RemoveProductStockUsecaseImp({required this.repository});
  @override
  Future<void> call(ProductEntity product) async {
    await repository.removeProductStock(product);
  }
}
