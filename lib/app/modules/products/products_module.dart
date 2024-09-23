import 'package:checkout/app/app_routes.dart';
import 'package:checkout/app/modules/products/data/products_datasource.dart';
import 'package:checkout/app/modules/products/data/products_repository.dart';
import 'package:checkout/app/modules/products/presentation/pages/products_page.dart';
import 'package:checkout/app/utils/custom_inject.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/products_repository.dart';
import 'domain/usecases/add_product_stock_usecase.dart';
import 'domain/usecases/fetch_products_stock_usecase.dart';
import 'presentation/controllers/products_controller.dart';

class ProductsModule extends Module {
  @override
  void binds(Injector i) {
    /* DATASOURCE */
    i.addLazySingleton<ProductsDatasource>(ProductsDatasourceImp.new);
    /* REPOSITORIES */
    i.addLazySingleton<ProductsRepository>(ProductsRepositoryImp.new);
    /* SERVICES */
    /* USECASES */
    i.addLazySingleton<FetchProductsStockUsecase>(FetchProductsStockUsecaseImp.new);
    i.addLazySingleton<AddProductStockUsecase>(AddProductStockUsecaseImp.new);
    /* CONTROLLERS */
    i.add<ProductsController>(ProductsController.new);
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.products, child: (context) => ProductsPage(controller: CustomInject.get<ProductsController>()));
  }
}
