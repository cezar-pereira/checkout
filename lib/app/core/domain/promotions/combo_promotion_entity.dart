import '../discount_entity.dart';
import '../product_entity.dart';
import '../promotion.dart';

class ComboPromotionEntity extends Promotion {
  final String sku1;
  final String sku2;
  final double comboPrice;

  ComboPromotionEntity(this.sku1, this.sku2, this.comboPrice);

  @override
  DiscountEntity? apply(List<ProductEntity> items) {
    int countItem1 = items.where((item) => item.sku == sku1).length;
    int countItem2 = items.where((item) => item.sku == sku2).length;

    if (countItem1 == 0 || countItem2 == 0) return null;

    int comboCount = countItem1 < countItem2 ? countItem1 : countItem2;
    double total = comboCount * comboPrice;

    ProductEntity item1 = items.firstWhere((item) => item.sku == sku1);
    ProductEntity item2 = items.firstWhere((item) => item.sku == sku2);

    double remaining1 = (countItem1 - comboCount) * item1.unitPrice;
    double remaining2 = (countItem2 - comboCount) * item2.unitPrice;

    final priceToPay = total + remaining1 + remaining2;
    final totalDiscount = (countItem1 * item1.unitPrice) + (countItem2 * item2.unitPrice) - priceToPay;

    return DiscountEntity(items: [item1, item2], totalDiscount: totalDiscount, priceToPay: priceToPay);
  }

  @override
  String toString() {
    return 'Produtos: $sku1 e $sku2 | Preço promocional: $comboPrice';
  }

  @override
  String get label => 'Oferta combinada';
}
