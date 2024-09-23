import 'package:checkout/app/core/domain/promotion.dart';
import 'package:checkout/app/modules/promotions/data/promotions_datasource.dart';

import '../domain/repositories/promotions_repository.dart';

class PromotionsRepositoryImp extends PromotionsRepository {
  final PromotionsDatasource datasource;

  PromotionsRepositoryImp({required this.datasource});

  @override
  Future<List<Promotion>> fetchPromotions() async {
    try {
      return await datasource.fetchPromotions();
    } catch (e) {
      rethrow;
    }
  }
}
