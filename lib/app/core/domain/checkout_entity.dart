import 'discount_entity.dart';
import 'product_entity.dart';
import 'promotion.dart';

class CheckoutEntity {
  final List<ProductEntity> _scannedItems = [];
  final List<Promotion> _promotions = [];
  final List<DiscountEntity> _discounts = [];
  double _subTotal = 0;

  double get subTotal => _subTotal;
  List<DiscountEntity> get discounts => _discounts;
  List<ProductEntity> get scannedItems => _scannedItems;

  double get total => _scannedItems.fold(0.0, (sum, item) => sum + item.unitPrice);

  void scanProduct(ProductEntity product) {
    _scannedItems.add(product);
  }

  void addPromotions(List<Promotion> promotions) {
    _promotions.addAll(promotions);
  }

  void calcTotal() {
    _discounts.clear();
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

    _subTotal = total;
  }
}
