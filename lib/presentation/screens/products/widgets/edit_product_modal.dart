import 'package:flutter/material.dart';
import '../models/productmodel.dart';
import '../../../theme/app_colors.dart';
<<<<<<< HEAD:lib/screens/products/widgets/edit_product_modal.dart
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';
=======
import '../../../widgets/custom_confirm_dialog.dart'; 
import '../../../widgets/custom_modal_sheet.dart';  
>>>>>>> origin/develop:lib/presentation/screens/products/widgets/edit_product_modal.dart

class EditProductModal extends StatefulWidget {
  const EditProductModal({super.key});

  static void show(BuildContext context) {
    CustomModalSheet.show(context: context, child: const EditProductModal());
  }

  @override
  State<EditProductModal> createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  bool _isEditing = false;
  String? _selectedUnit = Product.units.first;
  String? _selectedCategory = Product.categories.first;
  String? _selectedSupplier = Product.suppliers.first;
  String? _selectedBrand = Product.brands.first;
  String? _selectedStatus = Product.statuses.first;

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: _isEditing ? 'Editar Producto' : 'Detalle de Producto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Nombre del producto',
            hintText: 'Ej. Shampoo Keratina',
            enabled: _isEditing,
          ),
          const SizedBox(height: 14),

          CustomTextField(
            label: 'Descripción',
            hintText: 'Detalles del producto...',
            maxLines: 3,
            enabled: _isEditing,
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Unidad de Medida',
            value: _selectedUnit,
            items: Product.units,
            enabled: _isEditing,
            onChanged: (val) => setState(() => _selectedUnit = val),
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Categoría',
            value: _selectedCategory,
            items: Product.categories,
            enabled: _isEditing,
            onChanged: (val) => setState(() => _selectedCategory = val),
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Proveedor',
            value: _selectedSupplier,
            items: Product.suppliers,
            enabled: _isEditing,
            onChanged: (val) => setState(() => _selectedSupplier = val),
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Marca',
            value: _selectedBrand,
            items: Product.brands,
            enabled: _isEditing,
            onChanged: (val) => setState(() => _selectedBrand = val),
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Estado',
            value: _selectedStatus,
            items: Product.statuses,
            enabled: _isEditing,
            onChanged: (val) => setState(() => _selectedStatus = val),
          ),
          const SizedBox(height: 24),

<<<<<<< HEAD:lib/screens/products/widgets/edit_product_modal.dart
          _buildBottomButton(context),
=======
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => CustomConfirmDialog(
                    title: '¿Deseas guardar los cambios?',
                    message: 'La información del producto será actualizado.',
                    onConfirm: () {
                      Navigator.of(context).pop();      

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('¡Cambios guardados exitosamente!'),
                          backgroundColor: AppColors.primaryPurple,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.check, color: AppColors.white, size: 20),
              label: const Text(
                'Guardar Cambios',
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
>>>>>>> origin/develop:lib/presentation/screens/products/widgets/edit_product_modal.dart
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    if (!_isEditing) {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isEditing = true;
            });
          },
          icon: const Icon(
            Icons.edit_outlined,
            color: AppColors.white,
            size: 20,
          ),
          label: const Text(
            'Editar Producto',
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
      );
    } else {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) => CustomConfirmDialog(
                title: '¿Deseas guardar los cambios?',
                message: 'La información del producto será actualizada.',
                onConfirm: () {
                  Navigator.of(dialogContext).pop();
                  setState(() {
                    _isEditing = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('¡Cambios guardados exitosamente!'),
                      backgroundColor: AppColors.primaryPurple,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            );
          },
          icon: const Icon(Icons.check, color: AppColors.white, size: 20),
          label: const Text(
            'Guardar Cambios',
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
      );
    }
  }
}
