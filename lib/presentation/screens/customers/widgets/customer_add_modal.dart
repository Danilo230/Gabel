import 'package:flutter/material.dart';
import 'package:gabel/presentation/widgets/custom_confirm_dialog.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_modal_sheet.dart';

class NewCustomerModal extends StatefulWidget {
  const NewCustomerModal({super.key});

  static void show(BuildContext context) {
    CustomModalSheet.show(context: context, child: const NewCustomerModal());
  }

  @override
  State<NewCustomerModal> createState() => NewCustomerModalState();
}

class NewCustomerModalState extends State<NewCustomerModal> {
  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Nuevo cliente',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            label: 'Nombre del cliente',
            hintText: 'Ej. Ana',
          ),
          const SizedBox(height: 14),

          const CustomTextField(
            label: 'Apellido del cliente',
            hintText: 'Ej.Pérez',
          ),
          const SizedBox(height: 14),

          const CustomTextField(
            label: 'Numero de telefono',
            hintText: '58273212',
          ),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => CustomConfirmDialog(
                    title: '¿Desea guardar este cliente?',
                    message:
                        'El cliente sera ingresado a la listas de clientes',
                    onConfirm: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cliente guardado exitosamente'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add, color: AppColors.white, size: 20),
              label: const Text(
                'Guadar Cliente',
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
