import 'package:checkout/app/core/domain/checkout_entity.dart';
import 'package:checkout/app/core/domain/models/product_model.dart';

import 'package:checkout/app/core/domain/promotions/bulk_promotion_entity.dart';
import 'package:checkout/app/core/domain/promotions/combo_promotion_entity.dart';
import 'package:checkout/app/core/domain/promotions/free_item_promotion_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Checkout', () {
    test('should calculate total for single product with no promotions', () {
      var checkout = CheckoutEntity();
      checkout.scanProduct(ProductModel('A', 0.50));

      checkout.calcTotal();

      expect(checkout.total, equals(0.50));
    });

    test('should calculate total for two products with no promotions', () {
      var checkout = CheckoutEntity();
      checkout.scanProduct(ProductModel('A', 0.50));
      checkout.scanProduct(ProductModel('C', 1.50));

      checkout.calcTotal();

      expect(checkout.total, equals(2.0));
    });

    test('should handle promotions with no applicable items', () {
      var checkout = CheckoutEntity();
      checkout.scanProduct(ProductModel('A', 0.50));

      checkout.addPromotion(BulkPromotionEntity('B', 2, 1.25));
      checkout.addPromotion(FreeItemPromotionEntity('C', 3));
      checkout.addPromotion(ComboPromotionEntity('D', 'E', 3.00));

      checkout.calcTotal();

      expect(checkout.total, equals(0.50));
    });
  });

  group('BulkPromotionEntity', () {
    test('should apply bulk promotion for item B (2 for 1.25)', () {
      var checkout = CheckoutEntity();
      checkout.scanProduct(ProductModel('B', 0.75));
      checkout.scanProduct(ProductModel('B', 0.75));

      checkout.addPromotion(BulkPromotionEntity('B', 2, 1.25));

      checkout.calcTotal();

      expect(checkout.total, equals(1.25));
    });

    test('should calculate total correctly for more than 2 items of B', () {
      var checkout = CheckoutEntity();
      checkout.scanProduct(ProductModel('B', 0.75));
      checkout.scanProduct(ProductModel('B', 0.75));
      checkout.scanProduct(ProductModel('B', 0.75));

      checkout.addPromotion(BulkPromotionEntity('B', 2, 1.25));

      checkout.calcTotal();

      expect(checkout.total, equals(2.0)); // 2 for 1.25 + 1 for 0.75
    });
  });

  group('FreeItemPromotionEntity', () {
    test('should apply free item promotion for item C (Buy 3, get 1 free)', () {
      var checkout = CheckoutEntity();
      checkout.scanProduct(ProductModel('C', 0.25));
      checkout.scanProduct(ProductModel('C', 0.25));
      checkout.scanProduct(ProductModel('C', 0.25));
      checkout.scanProduct(ProductModel('C', 0.25));

      checkout.addPromotion(FreeItemPromotionEntity('C', 3));

      checkout.calcTotal();

      expect(checkout.total, equals(0.75)); // Pay for 3, 1 free
    });
  });

  group('ComboPromotionEntity', () {
    test('should apply combo promotion for items D and E', () {
      var checkout = CheckoutEntity();
      checkout.scanProduct(ProductModel('D', 1.50));
      checkout.scanProduct(ProductModel('E', 2.00));

      checkout.addPromotion(ComboPromotionEntity('D', 'E', 3.00));

      checkout.calcTotal();

      expect(checkout.total, equals(3.00));
    });
  });

  group('Mixed promotions', () {
    test('should handle mixed promotions correctly', () {
      var checkout = CheckoutEntity();
      checkout.scanProduct(ProductModel('D', 3));
      checkout.scanProduct(ProductModel('E', 3));
      checkout.scanProduct(ProductModel('F', 3));
      checkout.scanProduct(ProductModel('C', 2));

      checkout.scanProduct(ProductModel('B', 2));
      checkout.scanProduct(ProductModel('B', 2));
      checkout.scanProduct(ProductModel('A', 1));
      checkout.scanProduct(ProductModel('B', 2));
      checkout.scanProduct(ProductModel('A', 1));
      checkout.scanProduct(ProductModel('A', 1));
      checkout.scanProduct(ProductModel('B', 2));
      checkout.scanProduct(ProductModel('B', 2));
      checkout.scanProduct(ProductModel('B', 2));
      checkout.scanProduct(ProductModel('C', 2));
      checkout.scanProduct(ProductModel('A', 1));
      checkout.scanProduct(ProductModel('B', 2));
      checkout.scanProduct(ProductModel('A', 1));
      checkout.scanProduct(ProductModel('C', 2));

      /* ComboPromotion */
      // D + E => R$ 5,00
      double comboPromotionPrice = 5;

      /* FreeItemPromotion */
      // A: Pay for 4, 1 free => R$ 4,00
      // A: Pay for 5, 2 free => R$ 10,00

      double freeItemPromotionPrice = 14;

      /* BulkPromotion */
      // 2 for R$ 3,00 and 1 for R$ 2,00 => R$ 5,00
      double bulkPromotionPrice = 5;

      /* with no promotions */
      // F: R$ 3,00

      double withNoPromotionPrice = 3;

      checkout.addPromotion(ComboPromotionEntity('D', 'E', 5));
      checkout.addPromotion(FreeItemPromotionEntity('A', 3));
      checkout.addPromotion(FreeItemPromotionEntity('B', 3));
      checkout.addPromotion(BulkPromotionEntity('C', 2, 3));

      checkout.calcTotal();

      expect(
        checkout.total,
        equals(comboPromotionPrice + freeItemPromotionPrice + bulkPromotionPrice + withNoPromotionPrice),
      );
    });
  });
}
