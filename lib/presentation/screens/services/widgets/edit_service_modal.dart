import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../models/servicemodels.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class EditServiceModal extends StatefulWidget {
  const EditServiceModal({super.key});

  static void show(BuildContext context) {
    CustomModalSheet.show(context: context, child: const EditServiceModal());
  }

  @override
  State<EditServiceModal> createState() => _EditServiceModalState();
}

class _EditServiceModalState extends State<EditServiceModal> {
  bool _isEditing = false;
  String? _selectedEstilist = Service.estilists.first;
  String? _selectedStatus = Service.statuses.first;

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: _isEditing ? 'Editar servicio' : 'Detalle de servicio',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Nombre del servicio',
            hintText: 'Ej. Keratina',
            enabled: _isEditing,
          ),
          const SizedBox(height: 14),

          CustomTextField(
            label: 'Precio',
            hintText: '0.00',
            keyboardType: TextInputType.number,
            enabled: _isEditing,
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Nombre del estilista',
            value: _selectedEstilist,
            items: Service.estilists,
            onChanged: (val) => setState(() => _selectedEstilist = val),
          ),
          const SizedBox(height: 14),

          CustomTextField(
            label: 'Descripción',
            hintText: 'Detalles del servicio...',
            maxLines: 3,
            enabled: _isEditing,
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Estado',
            value: _selectedStatus,
            items: Service.statuses,
            enabled: _isEditing,
            onChanged: (val) => setState(() => _selectedStatus = val),
          ),
          const SizedBox(height: 24),

          _buildBottomButton(context),
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
            'Editar servicio',
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
                message: 'La información del servicio será actualizada.',
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
