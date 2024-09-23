import 'package:checkout/app/core/domain/promotion.dart';

import '../../../core/domain/promotions/bulk_promotion_entity.dart';
import '../../../core/domain/promotions/combo_promotion_entity.dart';
import '../../../core/domain/promotions/free_item_promotion_entity.dart';

sealed class PromotionsDatasource {
  Future<List<Promotion>> fetchPromotions();
}

class PromotionsDatasourceImp extends PromotionsDatasource {
  @override
  Future<List<Promotion>> fetchPromotions() async {
    return [
      ComboPromotionEntity('D', 'E', 5),
      FreeItemPromotionEntity('A', 3),
      FreeItemPromotionEntity('B', 3),
      BulkPromotionEntity('C', 2, 3),
    ];
  }
}
