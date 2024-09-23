import 'package:checkout/app/core/domain/promotion.dart';

import '../repositories/promotions_repository.dart';

abstract class FetchPromotionsUsecase {
  Future<List<Promotion>> call();
}

class FetchPromotionsUsecaseImp implements FetchPromotionsUsecase {
  final PromotionsRepository repository;

  FetchPromotionsUsecaseImp({required this.repository});
  @override
  Future<List<Promotion>> call() async {
    return await repository.fetchPromotions();
  }
}
