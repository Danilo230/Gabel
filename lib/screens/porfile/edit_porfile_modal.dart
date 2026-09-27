import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_modal_sheet.dart';
import '../../widgets/custom_text_field.dart';

class EditProfileModal extends StatelessWidget {
  const EditProfileModal({super.key});

  static void show(BuildContext context) {
    CustomModalSheet.show(
      context: context,
      child: const CustomModalSheet(
        title: 'Editar Perfil',
        child: EditProfileModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextField(
          label: 'Nombre de Usuario',
          hintText: 'Ej. Juan Pérez',
        ),

        const SizedBox(height: 16),

        const CustomTextField(
          label: 'Identificación',
          hintText: 'Ej. 0412910071003D',
        ),

        const SizedBox(height: 16),

        _campoEstado(
          label: 'Estado',
          hint: 'Seleccionar estado',
          onTap: () {},
        ),

        const SizedBox(height: 16),

        const CustomTextField(
          label: 'Contraseña',
          hintText: 'Cambiar contraseña',
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
        ),

        const SizedBox(height: 16),

        const CustomTextField(
          label: 'Confirmar Contraseña',
          hintText: 'Reingrese la contraseña',
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
        ),

        const SizedBox(height: 24),

        CustomButton(
          text: 'Guardar cambios',
          icon: Icons.save_outlined,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _campoEstado({
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
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 8),

        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.borderGrey,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    hint,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textTertiary,
                    ),
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