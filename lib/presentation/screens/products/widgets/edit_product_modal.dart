import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/core/di/injection.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import 'package:gabel/presentation/providers/product_provider.dart';

class EditProductModal extends StatefulWidget {
  final ProductModel product;

  const EditProductModal({super.key, required this.product});

  static void show(BuildContext context, ProductModel product) {
    CustomModalSheet.show(
      context: context,
      child: EditProductModal(product: product),
    );
  }

  @override
  State<EditProductModal> createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  final ProductProvider _provider = getIt<ProductProvider>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _brandController;

  bool _isEditing = false;
  String? _selectedUnit;
  String? _selectedCategory;
  String? _selectedSupplier;
  late String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    final p = widget.product;

    _nameController = TextEditingController(text: p.productName);
    _descriptionController = TextEditingController(text: p.productDescription);
    _brandController = TextEditingController(text: p.brand);

    _selectedUnit = p.unitName.trim().isNotEmpty ? p.unitName.trim() : null;
    _selectedCategory = p.categoryName.trim().isNotEmpty
        ? p.categoryName.trim()
        : null;
    _selectedSupplier = p.supplierName.trim().isNotEmpty
        ? p.supplierName.trim()
        : null;
    _selectedStatus = p.productStatus ? 'Activo' : 'Inactivo';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _provider.loadCatalogs();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  List<String> _mergeWithCurrent(List<String> list, String? current) {
    final set = <String>{};
    for (final item in list) {
      if (item.trim().isNotEmpty) set.add(item.trim());
    }
    if (current != null && current.trim().isNotEmpty) {
      set.add(current.trim());
    }
    return set.toList()..sort();
  }

  int _pickId(int fromCatalog, int original) =>
      fromCatalog != 0 ? fromCatalog : original;

  Future<void> _saveChanges() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final original = widget.product;

    final unit = _selectedUnit ?? original.unitName;
    final category = _selectedCategory ?? original.categoryName;
    final supplier = _selectedSupplier ?? original.supplierName;

    final updatedProduct = await _provider.update(
      original.productId,
      ProductModel(
        productId: original.productId,
        productName: _nameController.text,
        productDescription: _descriptionController.text,
        brand: _brandController.text,
        unitId: _pickId(_provider.unitIdByName(unit), original.unitId),
        unitName: unit,
        categoryId: _pickId(
          _provider.categoryIdByName(category),
          original.categoryId,
        ),
        categoryName: category,
        supplierId: _pickId(
          _provider.supplierIdByName(supplier),
          original.supplierId,
        ),
        supplierName: supplier,
        productStatus: _selectedStatus == 'Activo',
      ),
    );

    if (updatedProduct != null) {
      if (mounted) navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Cambios guardados exitosamente'),
          backgroundColor: AppColors.primaryPurple,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            _provider.errorMessage ?? 'Error al guardar los cambios',
          ),
          backgroundColor: AppColors.strongRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _provider,
      builder: (context, _) {
        final unitItems = _mergeWithCurrent(
          _provider.availableUnits,
          _selectedUnit,
        );
        final categoryItems = _mergeWithCurrent(
          _provider.availableCategories,
          _selectedCategory,
        );
        final supplierItems = _mergeWithCurrent(
          _provider.availableSuppliers,
          _selectedSupplier,
        );

        return CustomModalSheet(
          title: _isEditing ? 'Editar Producto' : 'Detalle de Producto',
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
                maxLines: 3,
                controller: _descriptionController,
                enabled: _isEditing,
              ),
              const SizedBox(height: 14),

              CustomTextField(
                label: 'Marca',
                hintText: 'Ej. Pantene, Sedal...',
                controller: _brandController,
                enabled: _isEditing,
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Unidad de Medida',
                hintText: 'Selecciona una unidad',
                value: unitItems.contains(_selectedUnit) ? _selectedUnit : null,
                items: unitItems,
                enabled: _isEditing,
                onChanged: (val) => setState(() => _selectedUnit = val),
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Categoría',
                hintText: 'Selecciona una categoría',
                value: categoryItems.contains(_selectedCategory)
                    ? _selectedCategory
                    : null,
                items: categoryItems,
                enabled: _isEditing,
                onChanged: (val) => setState(() => _selectedCategory = val),
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Proveedor',
                hintText: 'Selecciona un proveedor',
                value: supplierItems.contains(_selectedSupplier)
                    ? _selectedSupplier
                    : null,
                items: supplierItems,
                enabled: _isEditing,
                onChanged: (val) => setState(() => _selectedSupplier = val),
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Estado',
                value: _selectedStatus,
                items: const ['Activo', 'Inactivo'],
                enabled: _isEditing,
                onChanged: (val) => setState(() => _selectedStatus = val),
              ),
              const SizedBox(height: 24),

              _buildBottomButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    if (!_isEditing) {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() => _isEditing = true);
          },
          icon: const Icon(
            Icons.edit_outlined,
            color: AppColors.white,
            size: 20,
          ),
          label: const Text(
            'Editar producto',
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

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: _provider.isSaving
            ? null
            : () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => CustomConfirmDialog(
                    title: '¿Deseas guardar los cambios?',
                    message: 'La información del producto será actualizada.',
                    onConfirm: () {
                      Navigator.of(dialogContext).pop();
                      _saveChanges();
                    },
                  ),
                );
              },
        icon: _provider.isSaving
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.check, color: AppColors.white, size: 20),
        label: const Text(
          'Guardar cambios',
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
