import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';
import 'package:gabel/data/models/customer_model.dart';
import 'package:gabel/core/di/injection.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import 'package:gabel/presentation/providers/customer_provider.dart';

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
  final CustomerProvider _provider = getIt<CustomerProvider>();
  late final TextEditingController _nameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;

  bool _isEditing = false;
  late String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.customerName);
    _lastNameController = TextEditingController(
      text: widget.customer.customerLastName,
    );
    _phoneController = TextEditingController(
      text: widget.customer.customerPhone,
    );
    _selectedStatus = widget.customer.customerStatus ? 'Activo' : 'Inactivo';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final updatedCustomer = await _provider.update(
      widget.customer.customerId,
      CustomerModel(
        customerId: widget.customer.customerId,
        customerName: _nameController.text,
        customerLastName: _lastNameController.text,
        customerPhone: _phoneController.text,
        customerStatus: _selectedStatus == 'Activo',
      ),
    );

    if (updatedCustomer != null) {
      await _provider.refresh();
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
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: _isEditing ? 'Editar Cliente' : 'Detalle de Cliente',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Nombre del clinte',
            hintText: 'Ej. Juan',
            controller: _nameController,
            enabled: _isEditing,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Apellido del cliente',
            hintText: 'Ej. Pérez',
            controller: _lastNameController,
            enabled: _isEditing,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Teléfono',
            hintText: 'Ej. +505 88923213',
            controller: _phoneController,
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
    }
    return ListenableBuilder(
      listenable: _provider,
      builder: (context, _) {
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
                        message: 'La información del cliente será actualizada.',
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
      },
    );
  }
}
