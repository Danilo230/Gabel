import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/core/utils/num_extensions.dart';
import 'package:gabel/data/models/damaged_product_model.dart';
import 'package:gabel/data/models/inventory_model.dart';
import 'package:gabel/presentation/providers/damaged_product_provider.dart';
import 'package:gabel/presentation/providers/stylist_provider.dart';
import 'package:gabel/presentation/providers/user_provider.dart' show ViewStatus;

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown_field.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';

// modal que permite registrar un daño de un producto en el inventario

class RegisterDamageModal extends StatefulWidget {
  final InventoryModel item;

  const RegisterDamageModal({super.key, required this.item});

  @override
  State<RegisterDamageModal> createState() => _RegisterDamageModalState();
}

class _RegisterDamageModalState extends State<RegisterDamageModal> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final DamagedProductProvider _damagedProductProvider =
      getIt<DamagedProductProvider>();
  final StylistProvider _stylistProvider = getIt<StylistProvider>()
    ..fetchStylists();

  static const String _noStylist = 'Sin estilista';

  String? _selectedStylist;
  String? _error;

  @override
  void dispose() {
    _quantityController.dispose();
    _reasonController.dispose();
    _damagedProductProvider.dispose();
    _stylistProvider.dispose();
    super.dispose();
  }

  int? _selectedStylistId() {
    final stylist = _stylistProvider.stylists
        .where((stylist) => stylist.stylistName == _selectedStylist)
        .firstOrNull;

    return stylist?.stylistId;
  }

  Future<void> _confirm() async {
    final int? quantity = int.tryParse(_quantityController.text.trim());
    final String reason = _reasonController.text.trim();

    if (quantity == null || quantity <= 0) {
      setState(() => _error = 'Ingresa una cantidad válida.');
      return;
    }
    if (quantity > widget.item.stock) {
      setState(() => _error = 'La cantidad supera el stock actual.');
      return;
    }
    if (reason.isEmpty) {
      setState(() => _error = 'El motivo del daño es requerido.');
      return;
    }

    setState(() => _error = null);

    final DamagedProductModel? result = await _damagedProductProvider.register(
      CreateDamagedProductModel(
        inventoryId: widget.item.inventoryId,
        stylistId: _selectedStylistId(),
        quantity: quantity,
        damageReason: reason,
      ),
    );

    if (!mounted) return;

    if (result == null) {
      setState(() => _error = _damagedProductProvider.errorMessage);
      return;
    }

    Navigator.of(context).pop(result);
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
          ListenableBuilder(
            listenable: _stylistProvider,
            builder: (context, _) {
              final ViewStatus status = _stylistProvider.viewStatus;
              final bool isLoading =
                  status == ViewStatus.initial || status == ViewStatus.loading;
              final bool hasError = status == ViewStatus.error;
              final bool isEmpty = _stylistProvider.stylists.isEmpty;

              String hint = _noStylist;
              if (isLoading) {
                hint = 'Cargando estilistas...';
              } else if (hasError) {
                hint = 'No se pudieron cargar los estilistas';
              } else if (isEmpty) {
                hint = 'No hay estilistas disponibles';
              }

              return CustomDropdownField(
                label: 'Estilista Responsable (Opcional)',
                hint: hint,
                value: _selectedStylist,
                enabled: !isLoading && !hasError && !isEmpty,
                items: [
                  _noStylist,
                  ..._stylistProvider.stylists.map((stylist) => stylist.stylistName),
                ],
                onChanged: (name) => setState(() => _selectedStylist = name),
              );
            },
          ),
          if (_error != null) ...[
            const SizedBox(height: 14),
            Text(
              _error!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.red,
              ),
            ),
          ],
          const SizedBox(height: 24),
          ListenableBuilder(
            listenable: _damagedProductProvider,
            builder: (context, _) {
              final bool isSaving = _damagedProductProvider.isSaving;

              return CustomButton(
                text: isSaving ? 'Guardando...' : 'Confirmar Perdida',
                type: ButtonType.danger,
                icon: Icons.disabled_by_default_outlined,
                onPressed: isSaving ? null : _confirm,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _productHeader() {
    final InventoryModel item = widget.item;

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
                  item.productName,
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
            'Stock actual: ${item.stock.toQuantityString()} uds',
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