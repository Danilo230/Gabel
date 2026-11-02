import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';

class NewProductModal extends StatefulWidget {
  const NewProductModal({super.key});

  static Future<void> show(BuildContext context) {
    final provider = context.read<ProductProvider>();
    return CustomModalSheet.show(
      context: context,
      child: ChangeNotifierProvider.value(
        value: provider,
        child: const NewProductModal(),
      ),
    );
  }

  @override
  State<NewProductModal> createState() => _NewProductModalState();
}

class _NewProductModalState extends State<NewProductModal> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  String? _selectedBrand;
  String? _selectedUnit;
  String? _selectedCategory;
  String? _selectedSupplier;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProductProvider>().loadCatalogs();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalogs = context.watch<ProductProvider>();

    return CustomModalSheet(
      title: 'Nuevo producto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Nombre del producto',
            hintText: 'Ej. Shampoo Keratina',
            controller: _nameController,
          ),
          const SizedBox(height: 14),

          CustomTextField(
            label: 'Descripción',
            hintText: 'Detalles del producto...',
            controller: _descriptionController,
            maxLines: 3,
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Marca',
            value: _selectedBrand,
            items: catalogs.brands,
            onChanged: (val) => setState(() => _selectedBrand = val),
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Unidad de Medida',
            value: _selectedUnit,
            items: catalogs.units,
            onChanged: (val) => setState(() => _selectedUnit = val),
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Categoría',
            value: _selectedCategory,
            items: catalogs.categories,
            onChanged: (val) => setState(() => _selectedCategory = val),
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Proveedor',
            value: _selectedSupplier,
            items: catalogs.suppliers,
            onChanged: (val) => setState(() => _selectedSupplier = val),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _isSaving ? null : _showConfirmationDialog,
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

  void _showConfirmationDialog() {
    final provider = context.read<ProductProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      builder: (_) => CustomConfirmDialog(
        title: '¿Deseas guardar este producto?',
        message: 'El producto se añadirá al inventario.',
        onConfirm: () async {
          if (_isSaving) return;
          setState(() => _isSaving = true);

          final ok = await provider.createProduct(
            ProductModel(
              productId: 0,
              productName: _nameController.text,
              productDescription: _descriptionController.text,
              productBrand: _selectedBrand ?? '',
              productUnit: _selectedUnit ?? '',
              productCategory: _selectedCategory ?? '',
              productSupplier: _selectedSupplier ?? '',
              productStatus: true,
            ),
          );

          if (mounted) setState(() => _isSaving = false);
          if (ok) navigator.pop();

          messenger.showSnackBar(
            SnackBar(
              content: Text(
                ok
                    ? '¡Producto guardado exitosamente!'
                    : provider.errorMessage ??
                          'No se pudo guardar el producto.',
              ),
              backgroundColor: ok
                  ? AppColors.primaryPurple
                  : AppColors.strongRed,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }
}
