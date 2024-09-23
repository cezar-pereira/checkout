import 'package:checkout/app/app_routes.dart';
import 'package:checkout/app/modules/products/products_module.dart';
import 'package:checkout/app/modules/promotions/promotions_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/custom_inject.dart';
import 'presentation/controllers/checkout_controller.dart';
import 'presentation/pages/checkout_page.dart';

class CheckoutModule extends Module {
  @override
  List<Module> get imports => [ProductsModule(), PromotionsModule()];

  @override
  void binds(Injector i) {
    /* DATASOURCE */
    /* REPOSITORIES */
    /* SERVICES */
    /* USECASES */
    /* CONTROLLERS */
    i.add<CheckoutController>(CheckoutController.new);
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.checkout, child: (context) => CheckoutPage(controller: CustomInject.get<CheckoutController>()));
  }
}
