import 'package:checkout/app/core/domain/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(super.sku, super.unitPrice);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(json['sku'], json['unitPrice']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'sku': sku, 'unitPrice': unitPrice};
  }
}
