import 'package:flutter/material.dart';
import '../models/productmodel.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';

class NewProductModal extends StatefulWidget {
  const NewProductModal({super.key});

  static void show(BuildContext context) {
    CustomModalSheet.show(context: context, child: const NewProductModal());
  }

  @override
  State<NewProductModal> createState() => _NewProductModalState();
}

class _NewProductModalState extends State<NewProductModal> {
  String? _selectedUnit = Product.units.first;
  String? _selectedCategory = Product.categories.first;
  String? _selectedSupplier = Product.suppliers.first;

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Nuevo producto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            label: 'Nombre del producto',
            hintText: 'Ej. Shampoo Keratina',
          ),
          const SizedBox(height: 14),

          const CustomTextField(
            label: 'Descripción',
            hintText: 'Detalles del producto...',
            maxLines: 3,
          ),
          const SizedBox(height: 14),

          const CustomTextField(label: 'Marca', hintText: 'Ej. Savilé'),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Unidad de Medida',
            hint: 'Seleccionar unidad',
            value: _selectedUnit,
            items: Product.units,
            onChanged: (val) => setState(() => _selectedUnit = val),
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Categoría',
            hint: 'Seleccionar categoría',
            value: _selectedCategory,
            items: Product.categories,
            onChanged: (val) => setState(() => _selectedCategory = val),
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Proveedor',
            hint: 'Seleccionar proveedor',
            value: _selectedSupplier,
            items: Product.suppliers,
            onChanged: (val) => setState(() => _selectedSupplier = val),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => CustomConfirmDialog(
                    title: '¿Deseas guardar este producto?',
                    message: 'El producto se añadirá al inventario.',
                    onConfirm: () {
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('¡Producto guardado exitosamente!'),
                          backgroundColor: AppColors.primaryPurple,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add, color: AppColors.white, size: 20),
              label: const Text(
                'Guardar Producto',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
