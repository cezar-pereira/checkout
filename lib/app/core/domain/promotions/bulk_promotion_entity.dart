import '../discount_entity.dart';
import '../product_entity.dart';
import '../promotion.dart';

class BulkPromotionEntity extends Promotion {
  final String sku;
  final int requiredQuantity;
  final double specialPrice;

  BulkPromotionEntity(this.sku, this.requiredQuantity, this.specialPrice);

  @override
  DiscountEntity? apply(List<ProductEntity> items) {
    int count = items.where((item) => item.sku == sku).length;
    if (count == 0) return null;
    ProductEntity item = items.firstWhere((item) => item.sku == sku);

    double priceToPay = (count ~/ requiredQuantity) * specialPrice;
    priceToPay += (count % requiredQuantity) * item.unitPrice;

    final totalDiscount = (count * item.unitPrice) - priceToPay;

    return DiscountEntity(
      items: List.generate(count, (index) => item),
      totalDiscount: totalDiscount,
      priceToPay: priceToPay,
    );
  }

  @override
  String toString() => 'Produto: $sku | Quantidade mínima: $requiredQuantity | Preço especial: $specialPrice';

  @override
  String get label => 'Preço em múltiplos';
}
