import 'package:checkout/app/core/domain/promotion.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/fetch_promotions_usecase.dart';

class PromotionsController extends ChangeNotifier {
  final FetchPromotionsUsecase fetchPromotionsUsecase;
  PromotionsController({required this.fetchPromotionsUsecase}) {
    _fetchPromotions();
  }

  List<Promotion> _promotions = [];

  List<Promotion> get promotions => _promotions;

  Future<void> _fetchPromotions() async {
    try {
      final result = await fetchPromotionsUsecase();
      _promotions = result;
    } catch (e) {
      //TODO
    }

    notifyListeners();
  }
}
