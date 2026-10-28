import 'package:flutter/material.dart';
import '../../../../data/models/service_models.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_confirm_dialog.dart';
import '../../../widgets/custom_filter_dropdown.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';

class NewServiceModal extends StatefulWidget {
  const NewServiceModal({super.key});

  static void show(BuildContext context) {
    CustomModalSheet.show(context: context, child: const NewServiceModal());
  }

  @override
  State<NewServiceModal> createState() => _NewServiceModalState();
}

class _NewServiceModalState extends State<NewServiceModal> {
  String? _selectedEstilist;

  List<String> serviceEstilists = ['Maria', 'Martha'];

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Nuevo servicio',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            label: 'Nombre del servicio',
            hintText: 'Ej. Corte y Peinado Profesional',
          ),
          const SizedBox(height: 14),

          const CustomTextField(
            label: 'Precio del servicio',
            hintText: 'Ej. \$35.00',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),

          CustomFilterDropdown(
            label: 'Nombre del estilista',
            value: _selectedEstilist,
            items: serviceEstilists,
            onChanged: (val) => setState(() => _selectedEstilist = val),
          ),
          const SizedBox(height: 14),

          const CustomTextField(
            label: 'Descripción',
            hintText: 'Detalles del servicio...',
            maxLines: 3,
          ),
          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => CustomConfirmDialog(
                    title: '¿Deseas guardar este servicio?',
                    message: 'El servicio estará disponible.',
                    onConfirm: () {
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('¡Servicio guardado exitosamente!'),
                          backgroundColor: AppColors.primaryPurple,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add, color: AppColors.white, size: 20),
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
