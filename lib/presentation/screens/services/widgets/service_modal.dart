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
  static const String _noStylists = 'Sin estilistas disponibles';

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedStylist;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.provider.loadStylistsCatalog();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _currentStylist(List<String> stylists) {
    if (_selectedStylist != null && stylists.contains(_selectedStylist)) {
      return _selectedStylist;
    }
    return stylists.isNotEmpty ? stylists.first : null;
  }

  Future<void> _saveService() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final provider = widget.provider;

    final stylist = _currentStylist(provider.availableStylists) ?? '';
    final price =
        double.tryParse(
          _priceController.text.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        0;
    final stylistId = provider.stylistIdByName(stylist);

    setState(() => _isSaving = true);

    final created = await provider.register(
      ServiceModels(
        serviceId: 0,
        serviceName: _nameController.text,
        serviceDescription: _descriptionController.text,
        servicePrice: price,
        stylistId: stylistId != 0 ? stylistId : null,
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
            provider.errorMessage ?? 'Error al registrar el servicio',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.provider,
      builder: (context, _) {
        final stylists = widget.provider.availableStylists;
        final stylistError = widget.provider.stylistError;

        return CustomModalSheet(
          title: 'Nuevo servicio',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (stylistError != null) ...[
                Text(
                  stylistError,
                  style: const TextStyle(
                    color: AppColors.strongRed,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
              ],

              CustomTextField(
                label: 'Nombre del servicio',
                hintText: 'Ej. Corte y Peinado Profesional',
                controller: _nameController,
              ),
              const SizedBox(height: 14),

              CustomTextField(
                label: 'Precio del servicio',
                hintText: 'Ej. 35.00',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                controller: _priceController,
              ),
              const SizedBox(height: 14),

              CustomFilterDropdown(
                label: 'Nombre del estilista',
                value: _currentStylist(stylists),
                items: stylists.isNotEmpty ? stylists : const [_noStylists],
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
                      : const Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 20,
                        ),
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
      },
    );
  }
}
