import 'package:checkout/app/core/domain/promotion.dart';

abstract class PromotionsRepository {
  Future<List<Promotion>> fetchPromotions();
}
