import 'package:flutter/material.dart';
import '../controllers/promotions_controller.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({super.key, required this.controller});
  final PromotionsController controller;

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  PromotionsController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return controller.promotions.isEmpty
              ? const Center(child: Text('Sem promoções'))
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final promotion = controller.promotions[index];
                    return ListTile(
                      title: Text(promotion.label),
                      subtitle: Text(promotion.toString()),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: controller.promotions.length,
                );
        },
      ),
    );
  }
}
