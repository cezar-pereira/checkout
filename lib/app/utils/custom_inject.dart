import 'package:flutter_modular/flutter_modular.dart';

class CustomInject {
  static B get<B extends Object>({String? key}) {
    return Modular.get<B>();
  }
}
