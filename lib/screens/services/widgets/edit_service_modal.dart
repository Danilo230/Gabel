import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_modal_sheet.dart';  

class EditServiceModal extends StatelessWidget {
  const EditServiceModal({super.key});

  static void show(BuildContext context) {
    CustomModalSheet.show(
      context: context,
      child: const EditServiceModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Editar Servicio',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: 'Nombre del servicio',
            hint: 'Ej. Corte',
          ),
          const SizedBox(height: 14),

          _buildTextField(
            label: 'Descripción',
            hint: 'Detalles del servicio...',
            maxLines: 3,
          ),
          const SizedBox(height: 14),

          _buildSelectField(
            label: 'Categoría',
            hint: 'Seleccionar categoría',
            onTap: () {},
          ),
          const SizedBox(height: 14),

          _buildSelectField(
            label: 'Producto Utilizado',
            hint: 'Seleccionar producto',
            onTap: () {},
          ),
          const SizedBox(height: 14),

          _buildTextField(
            label: 'Precio',
            hint: '0.00',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 14),

          _buildSelectField(
            label: 'Estado',
            hint: 'Seleccionar estado',
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
                    titulo: '¿Deseas guardar los cambios?',
                    mensaje: 'La información del servicio será actualizada.',
                    confirmText: 'Guardar',
                    cancelText: 'Cancelar',
                    onConfirm: () {
                      Navigator.of(dialogContext).pop(); 
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
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
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
          keyboardType: keyboardType,
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