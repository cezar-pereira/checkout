import 'package:checkout/app/core/domain/product_entity.dart';
import 'package:checkout/app/utils/custom_navigator.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/models/product_model.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget({super.key, required this.onConfirm});

  final ValueChanged<ProductEntity> onConfirm;

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final editSkuController = TextEditingController();
  final editPriceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ),
            const SizedBox(height: 16),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: editSkuController,
              decoration: const InputDecoration(
                hintText: 'SKU',
                label: Text('SKU'),
              ),
              validator: (value) {
                if (value?.isEmpty == true) return 'SKU requerido';
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: editPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Preço',
                label: Text('Preço'),
              ),
              validator: (value) {
                if (value?.isEmpty == true) return 'Preço requerido';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  widget.onConfirm(ProductModel(
                    editSkuController.text,
                    double.tryParse(editPriceController.text) ?? 0,
                  ));

                  CustomNavigator.pop();
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
