import 'package:flutter/material.dart';
import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/presentation/providers/service_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';

class NewServiceModal extends StatefulWidget {
  final ServicesProvider provider;

  const NewServiceModal({super.key, required this.provider});

  static Future<ServiceModels?> show(
    BuildContext context,
    ServicesProvider provider,
  ) async {
    return CustomModalSheet.show<ServiceModels>(
      context: context,
      child: NewServiceModal(provider: provider),
    );
  }

  @override
  State<NewServiceModal> createState() => _NewServiceModalState();
}

class _NewServiceModalState extends State<NewServiceModal> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedStilist;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final stylists = widget.provider.availableStylists;
    if (stylists.isNotEmpty) {
      _selectedStilist = stylists.first;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveService() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final name = _nameController.text.trim();
    final priceStr = _priceController.text.trim();
    final description = _descriptionController.text.trim();
    final stylist = _selectedStilist?.trim() ?? '';

    if (name.isEmpty || priceStr.isEmpty || stylist.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos requeridos.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final price = double.tryParse(priceStr.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (price == null || price <= 0) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa un precio válido mayor a 0.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    final created = await widget.provider.register(
      ServiceModels(
        serviceId: 0,
        serviceName: name,
        serviceDescription: description,
        servicePrice: price,
        stylistName: stylist,
        serviceStatus: true,
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
            widget.provider.errorMessage ?? 'Error al registrar el servicio',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stylists = widget.provider.availableStylists;
    final stylistOptions = stylists.isNotEmpty
        ? stylists
        : const ['Sin estilistas disponibles'];

    final currentStylistValue =
        (_selectedStilist != null && stylistOptions.contains(_selectedStilist))
        ? _selectedStilist
        : (stylists.isNotEmpty ? stylists.first : null);

    return CustomModalSheet(
      title: 'Nuevo servicio',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Nombre del servicio',
            hintText: 'Ej. Corte y Peinado Profesional',
            controller: _nameController,
          ),
          const SizedBox(height: 14),

          CustomTextField(
            label: 'Precio del servicio',
            hintText: 'Ej. 35.00',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: _priceController,
          ),
          const SizedBox(height: 14),

          CustomFilterDropdown(
            label: 'Nombre del estilista',
            value: currentStylistValue,
            items: stylistOptions,
            onChanged: (val) {
              if (val != null && val != 'Sin estilistas disponibles') {
                setState(() => _selectedStilist = val);
              }
            },
          ),
          const SizedBox(height: 14),

          CustomTextField(
            label: 'Descripción',
            hintText: 'Detalles del servicio...',
            maxLines: 3,
            controller: _descriptionController,
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _isSaving ? null : _saveService,
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
                'Guardar Servicio',
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
