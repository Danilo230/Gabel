import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_modal_sheet.dart';

class NewProductModal extends StatelessWidget {
  const NewProductModal({super.key});

  static void show(BuildContext context) {
    CustomModalSheet.show(
      context: context,
      child: const NewProductModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Nuevo producto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: 'Nombre del producto',
            hint: 'Ej. Shampoo Keratina',
          ),
          const SizedBox(height: 14),

          _buildTextField(
            label: 'Descripción',
            hint: 'Detalles del producto...',
            maxLines: 3,
          ),
          const SizedBox(height: 14),

          _buildTextField(
            label: 'Marca',
            hint: 'Ej. Savilé',
          ),
          const SizedBox(height: 14),

          _buildSelectField(
            label: 'Unidad de Medida',
            hint: 'Seleccionar unidad',
            onTap: () {},
          ),
          const SizedBox(height: 14),

          _buildSelectField(
            label: 'Categoría',
            hint: 'Seleccionar categoría',
            onTap: () {},
          ),
          const SizedBox(height: 14),

          _buildSelectField(
            label: 'Proveedor',
            hint: 'Seleccionar proveedor',
            onTap: () {},
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
                      Navigator.of(dialogContext).pop(); 
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

  Widget _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.textTertiary,
              fontSize: 13,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.borderGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primaryPurple),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectField({
    required String label,
    required String hint,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hint,
                  style: const TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 13,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.iconGrey,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}