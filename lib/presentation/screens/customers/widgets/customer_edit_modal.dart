import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';
import 'package:gabel/data/models/customer_model.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_filter_dropdown.dart';

class CustomerEditModal extends StatefulWidget {
  final CustomerModel customer;

  const CustomerEditModal({super.key, required this.customer});

  static void show(BuildContext context, CustomerModel customer) {
    CustomModalSheet.show(
      context: context,
      child: CustomerEditModal(customer: customer),
    );
  }

  @override
  State<CustomerEditModal> createState() => _CustomerEditModalState();
}

class _CustomerEditModalState extends State<CustomerEditModal> {
  bool _isEditing = false;
  late String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.customer.customerStatus ? 'Activo' : 'Inactivo';
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: _isEditing ? 'Editar Cliente' : 'Detalle de Cliente',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Nombre del clinte',
            hintText: 'Ej. Juan',
            enabled: _isEditing,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Apellido del cliente',
            hintText: 'Ej. Pérez',
            enabled: _isEditing,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Teléfono',
            hintText: 'Ej. +505 88923213',
            enabled: _isEditing,
          ),
          const SizedBox(height: 16),
          CustomFilterDropdown(
            label: 'Estado',
            value: _selectedStatus,
            items: const ['Activo', 'Inactivo'],
            onChanged: (val) => setState(() => _selectedStatus = val),
            enabled: _isEditing,
          ),

          SizedBox(height: 14),
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
            setState(() => _isEditing = true);
          },
          icon: const Icon(
            Icons.edit_outlined,
            color: AppColors.white,
            size: 20,
          ),
          label: const Text(
            'Editar cliente',
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
                message: 'La información del cliente será actualizada.',
                onConfirm: () {
                  Navigator.of(dialogContext).pop();
                  setState(() {
                    _isEditing = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cambios guardados exitosamente'),
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
      );
    }
  }
}
