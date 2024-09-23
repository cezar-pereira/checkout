import '../discount_entity.dart';
import '../product_entity.dart';
import '../promotion.dart';

class FreeItemPromotionEntity extends Promotion {
  final String sku;
  final int requiredQuantity;

  FreeItemPromotionEntity(this.sku, this.requiredQuantity);

  @override
  DiscountEntity? apply(List<ProductEntity> items) {
    int count = items.where((item) => item.sku == sku).length;
    if (count == 0) return null;

    ProductEntity item = items.firstWhere((item) => item.sku == sku);

    int payableCount = count - (count ~/ (requiredQuantity));

    final priceToPay = payableCount * item.unitPrice;
    final totalDiscount = (count - payableCount) * item.unitPrice;

    return DiscountEntity(
      items: List.generate(count, (index) => item),
      totalDiscount: totalDiscount,
      priceToPay: priceToPay,
    );
  }

  @override
  String toString() => 'Produto: $sku | Quantidade mínima: $requiredQuantity';

  @override
  String get label => 'Compre N e ganhe 1 grátis';
}
