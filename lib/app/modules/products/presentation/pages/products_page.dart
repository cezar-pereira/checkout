import 'package:checkout/app/modules/products/presentation/widgets/add_product_widget.dart';
import 'package:flutter/material.dart';

import '../controllers/products_controller.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.controller});
  final ProductsController controller;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductsController get controller => widget.controller;

  void _showDialogAddProduct() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: AddProductWidget(onConfirm: controller.addProduct),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return controller.productStock.isEmpty
              ? const Center(child: Text('Estoque vazio'))
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final product = controller.productStock[index];
                    return ListTile(
                      title: Text(product.sku),
                      subtitle: Text(product.unitPrice.toString()),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: controller.productStock.length,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogAddProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
