import 'package:checkout/app/modules/home/home_module.dart';
import 'package:checkout/app/modules/products/products_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/promotions/promotions_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    /* DATASOURCE */
    /* REPOSITORIES */
    /* SERVICES */
    /* USECASES */
    /* CONTROLLERS */
    super.binds(i);
  }

  @override
  void routes(r) {
    r.module(Modular.initialRoute, module: HomeModule());
    r.module(Modular.initialRoute, module: ProductsModule());
    r.module(Modular.initialRoute, module: PromotionsModule());
  }
}
