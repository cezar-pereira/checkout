import 'product_entity.dart';

class DiscountEntity {
  final List<ProductEntity> items;
  final double totalDiscount;
  final double priceToPay;

  DiscountEntity({required this.items, required this.totalDiscount, required this.priceToPay});

  double get discountPerItem => totalDiscount / items.length;

  List<String> printDiscount() {
    return items.map((item) => 'Desconto item ${item.sku} - ${discountPerItem.toStringAsFixed(2)}').toList();
  }
}
