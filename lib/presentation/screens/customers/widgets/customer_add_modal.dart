import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/data/models/customer_model.dart';
import 'package:gabel/presentation/providers/customer_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_modal_sheet.dart';

class NewCustomerModal extends StatefulWidget {
  final CustomerProvider provider;

  const NewCustomerModal({super.key, required this.provider});

  static Future<CustomerModel?> show(
    BuildContext context,
    CustomerProvider provider,
  ) async {
    return CustomModalSheet.show<CustomerModel>(
      context: context,
      child: NewCustomerModal(provider: provider),
    );
  }

  @override
  State<NewCustomerModal> createState() => _NewCustomerModalState();
}

class _NewCustomerModalState extends State<NewCustomerModal> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _customerProvider = getIt<CustomerProvider>();

  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _customerProvider.dispose();
    super.dispose();
  }

  Future<void> _saveCustomer() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    setState(() => _isSaving = true);
    final created = await widget.provider.register(
      CustomerModel(
        customerId: 0,
        customerName: _nameController.text,
        customerLastName: _lastNameController.text,
        customerPhone: _phoneController.text,
        customerStatus: true,
      ),
    );
    if (!mounted) return;
    setState(() => _isSaving = false);
    if (created != null) {
      navigator.pop(created);
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            widget.provider.errorMessage ?? 'Error al registrar el cliente',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Nuevo cliente',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Nombre del cliente',
            hintText: 'Ej. Ana',
            controller: _nameController,
          ),
          const SizedBox(height: 14),

          CustomTextField(
            label: 'Apellido del cliente',
            hintText: 'Ej.Pérez',
            controller: _lastNameController,
          ),
          const SizedBox(height: 14),

          CustomTextField(
            label: 'Numero de telefono',
            hintText: '58273212',
            controller: _phoneController,
          ),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _isSaving ? null : _saveCustomer,
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    )
  
                  : const Icon(Icons.check, color: AppColors.white, size: 20),
              label: const Text(
                'Guardar Cliente',
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
}
