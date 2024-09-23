import 'package:flutter/material.dart';

import '../controllers/checkout_controller.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.controller});

  final CheckoutController controller;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  CheckoutController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Checkout'),
            ),
            body: switch (controller.state) {
              CheckoutControllerState.loading => const Center(child: CircularProgressIndicator.adaptive()),
              CheckoutControllerState.error => const Center(child: Text('ERROR')),
              CheckoutControllerState.success => _CheckoutPageSuccess(controller: controller),
            });
      },
    );
  }
}

class _CheckoutPageSuccess extends StatefulWidget {
  const _CheckoutPageSuccess({required this.controller});

  final CheckoutController controller;

  @override
  State<_CheckoutPageSuccess> createState() => _CheckoutPageSuccessState();
}

class _CheckoutPageSuccessState extends State<_CheckoutPageSuccess> {
  CheckoutController get controller => widget.controller;

  void _showListProducts() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final product = controller.productStock[index];
                    return ElevatedButton(
                      onPressed: () {
                        controller.addProduct(product);
                        Navigator.pop(context);
                      },
                      child: Text(product.sku),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemCount: controller.productStock.length,
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'PRODUTOS NO CARRINHO:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Visibility(
              visible: widget.controller.checkout.scannedItems.isNotEmpty,
              replacement: const Text('Carrinho vazio'),
              child: Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.controller.checkout.scannedItems[index].sku,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'R\$ ${widget.controller.checkout.scannedItems[index].unitPrice}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemCount: widget.controller.checkout.scannedItems.length),
              ),
            ),
            if (widget.controller.checkout.scannedItems.isNotEmpty) ...[
              Text('Total: ${widget.controller.checkout.total}'),
              Text('Subtotal: ${widget.controller.checkout.subTotal}'),
              if (widget.controller.checkout.discounts.isNotEmpty) const Text('Descontos:'),
              if (widget.controller.checkout.discounts.isNotEmpty)
                ...List.generate(
                  widget.controller.checkout.discounts.length,
                  (index) {
                    final discount = widget.controller.checkout.discounts[index];
                    return Text(discount.printDiscount().toString());
                  },
                ),
              const SizedBox(height: 24),
            ]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showListProducts,
        tooltip: 'Adicionar produto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
