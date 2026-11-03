import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/data/models/service_models.dart';
import 'package:gabel/presentation/providers/service_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';

class EditServiceModal extends StatefulWidget {
  final ServiceModels service;

  const EditServiceModal({super.key, required this.service});

  static void show(BuildContext context, ServiceModels service) {
    CustomModalSheet.show(
      context: context,
      child: EditServiceModal(service: service),
    );
  }

  @override
  State<EditServiceModal> createState() => _EditServiceModalState();
}

class _EditServiceModalState extends State<EditServiceModal> {
  static const String _noStylists = 'Sin estilistas disponibles';

  final ServicesProvider _provider = getIt<ServicesProvider>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;

  bool _isEditing = false;
  String? _selectedStylist;
  late String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    final s = widget.service;

    _nameController = TextEditingController(text: s.serviceName);
    _priceController = TextEditingController(
      text: s.servicePrice.toStringAsFixed(2),
    );
    _descriptionController = TextEditingController(text: s.serviceDescription);
    _selectedStylist = s.stylistName;
    _selectedStatus = s.serviceStatus ? 'Activo' : 'Inactivo';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _provider.loadStylistsCatalog();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<String> _stylistOptions() {
    final set = Set<String>.from(_provider.availableStylists);
    final current = _selectedStylist;
    if (current != null && current.isNotEmpty) set.add(current);
    return set.isNotEmpty ? (set.toList()..sort()) : const [_noStylists];
  }

  Future<void> _saveChanges() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final original = widget.service;

    final stylist = _selectedStylist ?? original.stylistName;
    final price =
        double.tryParse(
          _priceController.text.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        0;
    final catalogId = _provider.stylistIdByName(stylist);

    final updated = await _provider.update(
      original.serviceId,
      ServiceModels(
        serviceId: original.serviceId,
        serviceName: _nameController.text,
        serviceDescription: _descriptionController.text,
        servicePrice: price,
        stylistId: catalogId != 0 ? catalogId : original.stylistId,
        stylistName: stylist,
        serviceStatus: _selectedStatus == 'Activo',
      ),
    );

    if (updated != null) {
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

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _provider,
      builder: (context, _) {
        final stylistOptions = _stylistOptions();

        return CustomModalSheet(
          title: _isEditing ? 'Editar servicio' : 'Detalle de servicio',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Nombre del servicio',
                hintText: 'Ej. Keratina',
                controller: _nameController,
                enabled: _isEditing,
              ),
              const SizedBox(height: 14),

              CustomTextField(
                label: 'Precio',
                hintText: '0.00',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                controller: _priceController,
                enabled: _isEditing,
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Nombre del estilista',
                value: stylistOptions.contains(_selectedStylist)
                    ? _selectedStylist
                    : stylistOptions.first,
                items: stylistOptions,
                enabled: _isEditing,
                onChanged: (val) {
                  if (val != null && val != _noStylists) {
                    setState(() => _selectedStylist = val);
                  }
                },
              ),
              const SizedBox(height: 14),

              CustomTextField(
                label: 'Descripción',
                hintText: 'Detalles del servicio...',
                maxLines: 3,
                controller: _descriptionController,
                enabled: _isEditing,
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Estado',
                value: _selectedStatus,
                items: const ['Activo', 'Inactivo'],
                enabled: _isEditing,
                onChanged: (val) => setState(() => _selectedStatus = val),
              ),
              const SizedBox(height: 24),

              _buildBottomButton(context),
            ],
          ),
        );
      },
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
    }

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
                    message: 'La información del servicio será actualizada.',
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
  }
}
