import 'package:checkout/app/app_routes.dart';
import 'package:checkout/app/utils/custom_navigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendinha do zé')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => CustomNavigator.pushNamed(AppRoutes.products),
              label: const Text('Produtos'),
              icon: const Icon(Icons.format_align_left_sharp),
            ),
            ElevatedButton.icon(
              onPressed: () => CustomNavigator.pushNamed(AppRoutes.promotions),
              label: const Text('Promoções'),
              icon: const Icon(Icons.discount),
            ),
            ElevatedButton.icon(
              onPressed: () => CustomNavigator.pushNamed(AppRoutes.checkout),
              label: const Text('Iniciar venda'),
              icon: const Icon(Icons.add_shopping_cart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
