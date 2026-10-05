import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';
import '../models/product.dart';

// modal que permite registrar un daño de un producto en el inventario

class DamageRecord {
  final int quantity;
  final String reason;
  final String stylist;

  const DamageRecord({
    required this.quantity,
    required this.reason,
    required this.stylist,
  });
}

class RegisterDamageModal extends StatefulWidget {
  final Product product;

  const RegisterDamageModal({super.key, required this.product});

  @override
  State<RegisterDamageModal> createState() => _RegisterDamageModalState();
}

class _RegisterDamageModalState extends State<RegisterDamageModal> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _stylistController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    _reasonController.dispose();
    _stylistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Registrar Daño',
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productHeader(),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Cantidad Dañada (Requerido)',
            hintText: '0',
            controller: _quantityController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Motivo del Daño (Requerido)',
            hintText: 'Describa el motivo',
            controller: _reasonController,
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Estilista Responsable (Opcional)',
            hintText: 'Nombre del estilista',
            controller: _stylistController,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Confirmar Perdida',
            type: ButtonType.danger,
            icon: Icons.disabled_by_default_outlined,
            onPressed: null,
          ),
        ],
      ),
    );
  }

  Widget _productHeader() {
    final Product product = widget.product;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.paleLavender,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.inventory_2_outlined,
                color: AppColors.primaryPurple,
                size: 22,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Stock actual: ${product.stock} uds',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}