import 'package:checkout/app/modules/home/presentation/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_routes.dart';

class HomeModule extends Module {
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
    r.child(AppRoutes.home, child: (context) => const HomePage());
  }
}
