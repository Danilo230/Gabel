import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';

class EditProductModal extends StatefulWidget {
  final ProductModel product;

  const EditProductModal({super.key, required this.product});
  static Future<void> show(BuildContext context, ProductModel product) {
    final provider = context.read<ProductProvider>();
    return CustomModalSheet.show(
      context: context,
      child: ChangeNotifierProvider.value(
        value: provider,
        child: EditProductModal(product: product),
      ),
    );
  }

  @override
  State<EditProductModal> createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  static const String _active = 'Activo';
  static const String _inactive = 'Inactivo';

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  late String _selectedBrand;
  late String _selectedUnit;
  late String _selectedCategory;
  late String _selectedSupplier;
  late String _selectedStatus;

  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final p = widget.product;

    _nameController = TextEditingController(text: p.productName);
    _descriptionController = TextEditingController(text: p.productDescription);

    _selectedBrand = p.brand;
    _selectedUnit = p.unitName;
    _selectedCategory = p.categoryName;
    _selectedSupplier = p.supplierName;
    _selectedStatus = p.productStatus ? _active : _inactive;

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

  List<String> _withCurrent(List<String> items, String current) {
    if (current.isEmpty || items.contains(current)) return items;
    return [...items, current];
  }

  @override
  Widget build(BuildContext context) {
    final catalogs = context.read<ProductProvider>();

    return CustomModalSheet(
      title: _isEditing ? 'Editar producto' : 'Detalle del producto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Nombre del producto',
            hintText: 'Ej. Shampoo Keratina',
            controller: _nameController,
            enabled: _isEditing,
          ),
          const SizedBox(height: 14),

          CustomTextField(
            label: 'Descripción',
            hintText: 'Detalles del producto...',
            controller: _descriptionController,
            maxLines: 3,
            enabled: _isEditing,
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Marca',
            value: _selectedBrand,
            items: _withCurrent(catalogs.brands, _selectedBrand),
            enabled: _isEditing,
            onChanged: (val) =>
                setState(() => _selectedBrand = val ?? _selectedBrand),
          ),

          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Unidad de Medida',
            value: _selectedUnit,
            items: _withCurrent(catalogs.units, _selectedUnit),
            enabled: _isEditing,
            onChanged: (val) =>
                setState(() => _selectedUnit = val ?? _selectedUnit),
          ),

          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Categoría',
            value: _selectedCategory,
            items: _withCurrent(catalogs.categories, _selectedCategory),
            enabled: _isEditing,
            onChanged: (val) =>
                setState(() => _selectedCategory = val ?? _selectedCategory),
          ),

          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Proveedor',
            value: _selectedSupplier,
            items: _withCurrent(catalogs.suppliers, _selectedSupplier),
            enabled: _isEditing,
            onChanged: (val) =>
                setState(() => _selectedSupplier = val ?? _selectedSupplier),
          ),

          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Estado',
            value: _selectedStatus,
            items: const [_active, _inactive],
            enabled: _isEditing,
            onChanged: (val) =>
                setState(() => _selectedStatus = val ?? _selectedStatus),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _isSaving
                  ? null
                  : _isEditing
                  ? _showConfirmationDialog
                  : () => setState(() => _isEditing = true),
              icon: Icon(
                _isEditing ? Icons.save_outlined : Icons.edit_outlined,
                color: AppColors.white,
                size: 20,
              ),
              label: Text(
                _isEditing ? 'Guardar Cambios' : 'Editar Producto',
                style: const TextStyle(
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

    showDialog(
      context: context,
      builder: (_) => CustomConfirmDialog(
        title: '¿Deseas guardar los cambios?',
        message: 'La información del producto se actualizará.',

        onConfirm: () async {
          if (_isSaving) return;
          setState(() => _isSaving = true);

          final ok = await provider.updateProduct(
            widget.product.productId,
            ProductModel(
              productId: widget.product.productId,
              productName: _nameController.text,
              productDescription: _descriptionController.text,
              brand: _selectedBrand,
              unitName: _selectedUnit,
              categoryName: _selectedCategory,
              supplierName: _selectedSupplier,
              productStatus: _selectedStatus == _active,
            ),
          );

          if (mounted) {
            setState(() {
              _isSaving = false;
              if (ok) _isEditing = false;
            });
          }

          messenger.showSnackBar(
            SnackBar(
              content: Text(
                ok
                    ? '¡Producto actualizado exitosamente!'
                    : provider.errorMessage ??
                          'No se pudo actualizar el producto.',
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
