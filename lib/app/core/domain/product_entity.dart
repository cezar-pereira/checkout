abstract class ProductEntity {
  final String sku;
  final double unitPrice;

  ProductEntity(this.sku, this.unitPrice);

  Map<String, dynamic> toJson();
}
