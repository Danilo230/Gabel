import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/data/models/product_model.dart';
import 'package:gabel/presentation/providers/product_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_filter_dropdown.dart';

class NewProductModal extends StatefulWidget {
  final ProductProvider provider;

  const NewProductModal({super.key, required this.provider});

  static Future<ProductModel?> show(
    BuildContext context, [
    ProductProvider? provider,
  ]) async {
    final p = provider ?? getIt<ProductProvider>();
    return CustomModalSheet.show<ProductModel>(
      context: context,
      child: NewProductModal(provider: p),
    );
  }

  @override
  State<NewProductModal> createState() => _NewProductModalState();
}

class _NewProductModalState extends State<NewProductModal> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _brandController = TextEditingController();

  String? _selectedUnit;
  String? _selectedCategory;
  String? _selectedSupplier;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.provider.loadCatalogs();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El nombre del producto es obligatorio.'),
          backgroundColor: AppColors.strongRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    setState(() => _isSaving = true);
    final created = await widget.provider.register(
      ProductModel(
        productId: 0,
        productName: name,
        productDescription: _descriptionController.text.trim(),
        brand: _brandController.text.trim(),
        unitName: _selectedUnit ?? '',
        categoryName: _selectedCategory ?? '',
        supplierName: _selectedSupplier ?? '',
        productStatus: true,
      ),
    );

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (created != null) {
      navigator.pop(created);
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Producto guardado exitosamente'),
          backgroundColor: AppColors.primaryPurple,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            widget.provider.errorMessage ?? 'Error al registrar el producto',
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
      listenable: widget.provider,
      builder: (context, _) {
        final units = widget.provider.availableUnits;
        final categories = widget.provider.availableCategories;
        final suppliers = widget.provider.availableSuppliers;

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

              CustomTextField(
                label: 'Marca',
                hintText: 'Ej. Pantene, Sedal...',
                controller: _brandController,
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Unidad de Medida',
                hintText: 'Selecciona una unidad',
                value: units.contains(_selectedUnit) ? _selectedUnit : null,
                items: units,
                onChanged: (val) => setState(() => _selectedUnit = val),
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Categoría',
                hintText: 'Selecciona una categoría',
                value: categories.contains(_selectedCategory)
                    ? _selectedCategory
                    : null,
                items: categories,
                onChanged: (val) => setState(() => _selectedCategory = val),
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Proveedor',
                hintText: 'Selecciona un proveedor',
                value: suppliers.contains(_selectedSupplier)
                    ? _selectedSupplier
                    : null,
                items: suppliers,
                onChanged: (val) => setState(() => _selectedSupplier = val),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _isSaving ? null : _saveProduct,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : const Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 20,
                        ),
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
      },
    );
  }
}
