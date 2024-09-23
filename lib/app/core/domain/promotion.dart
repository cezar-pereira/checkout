import 'package:checkout/app/core/domain/discount_entity.dart';

import 'product_entity.dart';

abstract class Promotion {
  DiscountEntity? apply(List<ProductEntity> items);
}
