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

  String? _error;

  @override
  void dispose() {
    _quantityController.dispose();
    _reasonController.dispose();
    _stylistController.dispose();
    super.dispose();
  }

  void _confirm() {
    final int? quantity = int.tryParse(_quantityController.text.trim());
    final String reason = _reasonController.text.trim();

    if (quantity == null || quantity <= 0) {
      setState(() => _error = 'Ingresa una cantidad valida');
      return;
    }
    if (quantity > widget.product.stock) {
      setState(() => _error = 'La cantidad supera el stock actual');
      return;
    }
    if (reason.isEmpty) {
      setState(() => _error = 'El motivo del daño es requerido');
      return;
    }

    Navigator.of(context).pop(
      DamageRecord(
        quantity: quantity,
        reason: reason,
        stylist: _stylistController.text.trim(),
      ),
    );
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
          const SizedBox(height: 22),
          CustomTextField(
            label: 'Cantidad Dañada (Requerido)',
            hintText: '0',
            controller: _quantityController,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() => _error = null),
          ),
          const SizedBox(height: 18),
          CustomTextField(
            label: 'Motivo del Daño (Requerido)',
            hintText: 'Describa el motivo',
            controller: _reasonController,
            maxLines: 4,
            onChanged: (_) => setState(() => _error = null),
          ),
          const SizedBox(height: 18),
          CustomTextField(
            label: 'Estilista Responsable (Opcional)',
            hintText: 'Nombre del estilista',
            controller: _stylistController,
          ),
          if (_error != null) ...[
            const SizedBox(height: 14),
            Text(
              _error!,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.strongRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 26),
          CustomButton(
            text: 'Confirmar Perdida',
            type: ButtonType.danger,
            icon: Icons.disabled_by_default_outlined,
            onPressed: _confirm,
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Cancelar',
            type: ButtonType.neutral,
            onPressed: () => Navigator.of(context).pop(),
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
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.inventory_2_rounded,
                size: 24, color: AppColors.mediumPurple),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Stock Actual: ${product.stock} uds',
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
