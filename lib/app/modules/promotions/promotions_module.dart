import 'package:checkout/app/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/custom_inject.dart';
import 'data/promotions_datasource.dart';
import 'data/promotions_repository.dart';
import 'domain/repositories/promotions_repository.dart';
import 'domain/usecases/fetch_promotions_usecase.dart';
import 'presentation/controllers/promotions_controller.dart';
import 'presentation/pages/promotions_page.dart';

class PromotionsModule extends Module {
  @override
  void binds(Injector i) {
    /* DATASOURCE */
    i.addLazySingleton<PromotionsDatasource>(PromotionsDatasourceImp.new);
    /* REPOSITORIES */
    i.addLazySingleton<PromotionsRepository>(PromotionsRepositoryImp.new);
    /* SERVICES */
    /* USECASES */
    i.addLazySingleton<FetchPromotionsUsecase>(FetchPromotionsUsecaseImp.new);
    /* CONTROLLERS */
    i.add<PromotionsController>(PromotionsController.new);
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.promotions,
        child: (context) => PromotionsPage(controller: CustomInject.get<PromotionsController>()));
  }
}
