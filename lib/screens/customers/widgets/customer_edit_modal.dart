import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../models/customer.dart';

class CustomerEditModal extends StatefulWidget {
  final Customer customer;

  const CustomerEditModal({super.key, required this.customer});

  static void show(BuildContext context, Customer customer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.45),
      builder: (context) {
        return CustomerEditModal(customer: customer);
      },
    );
  }

  @override
  State<CustomerEditModal> createState() => _CustomerEditModalState();
}

class _CustomerEditModalState extends State<CustomerEditModal> {
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.customer.customerStatus;
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Editar Cliente',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _field(label: 'Nombre', value: widget.customer.customerName),
          const SizedBox(height: 16),
          _field(label: 'Apellido', value: widget.customer.customerLastName),
          const SizedBox(height: 16),
          _field(label: 'Correo', value: widget.customer.customerEmail),
          const SizedBox(height: 16),
          _field(label: 'Teléfono', value: widget.customer.customerPhone),
          const SizedBox(height: 16),
          const Text(
            'Estado',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: selectedStatus,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderGrey),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'Activo', child: Text('Activo')),
              DropdownMenuItem(value: 'Inactivo', child: Text('Inactivo')),
            ],
            onChanged: (value) {
              setState(() {
                selectedStatus = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _field({required String label, required String value}) {
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
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
