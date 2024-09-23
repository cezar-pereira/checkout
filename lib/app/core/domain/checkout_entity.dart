import 'discount_entity.dart';
import 'product_entity.dart';
import 'promotion.dart';

class CheckoutEntity {
  final List<ProductEntity> _scannedItems = [];
  final List<Promotion> _promotions = [];
  final List<DiscountEntity> _discounts = [];
  double _total = 0;

  double get total => _total;
  List<DiscountEntity> get discounts => _discounts;

  void scanProduct(ProductEntity product) {
    _scannedItems.add(product);
  }

  void addPromotion(Promotion promotion) {
    _promotions.add(promotion);
  }

  void calcTotal() {
    double total = 0;
    List<ProductEntity> remainingItems = List.from(_scannedItems);

    for (var promotion in _promotions) {
      final discount = promotion.apply(remainingItems);
      if (discount == null) continue;

      _discounts.add(discount);
      // print('ITEM: ${discount.item.sku} - ${discount.priceToPay}');
      total += discount.priceToPay;

      // Remove os itens que já foram processados pela promoção
      for (var item in discount.items) {
        remainingItems.removeWhere((x) => x.sku == item.sku);
      }
    }

    // Somar os itens restantes que não têm promoção
    final sumItensWithOutPromotion = remainingItems.fold(0.0, (sum, item) => sum + item.unitPrice);
    total += sumItensWithOutPromotion;

    _total = total;
  }
}
