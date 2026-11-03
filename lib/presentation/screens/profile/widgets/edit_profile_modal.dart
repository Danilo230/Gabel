import 'package:flutter/material.dart';
import 'package:gabel/data/models/current_user_model.dart';
import 'package:gabel/presentation/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_modal_sheet.dart';
import '../../../widgets/custom_text_field.dart';

class EditProfileModal extends StatefulWidget {
  final CurrentUserModel user;
  const EditProfileModal({super.key, required this.user});

  static void show(BuildContext context, CurrentUserModel user) {
    final provider = context.read<ProfileProvider>();
    provider.clearSaveError();

    CustomModalSheet.show(
      context: context,
      child: ChangeNotifierProvider.value(
        value: provider,
        child: CustomModalSheet(
          title: 'Editar Perfil',
          child: EditProfileModal(user: user),
        ),
      ),
    );
  }

  @override
  State<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _userName;
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userName = TextEditingController(text: widget.user.userName);
  }

  @override
  void dispose() {
    _userName.dispose();
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProfileProvider>();
    final ok = await provider.saveProfile(
      userName: _userName.text,
      currentPassword: _currentPassword.text,
      newPassword: _newPassword.text,
      confirmPassword: _confirmPassword.text,
    );

    if (ok && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProfileProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Nombre de Usuario',
            hintText: 'Tu nombre de usuario',
            controller: _userName,
            validator: (v) =>
                (v == null || v.trim().length < 5) ? 'Mínimo 5 caracteres' : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Contraseña actual',
            hintText: 'Solo si vas a cambiarla',
            obscureText: true,
            controller: _currentPassword,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Nueva contraseña',
            hintText: 'Déjalo vacío para no cambiarla',
            obscureText: true,
            controller: _newPassword,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Confirmar nueva contraseña',
            hintText: 'Reingrese la nueva contraseña',
            obscureText: true,
            controller: _confirmPassword,
          ),
          if (p.saveError != null) ...[
            const SizedBox(height: 12),
            Text(p.saveError!, style: const TextStyle(color: Colors.red)),
          ],
          const SizedBox(height: 24),
          CustomButton(
            text: p.isSaving ? 'Guardando...' : 'Guardar cambios',
            icon: Icons.save_outlined,
            onPressed: p.isSaving ? null : _save,
          ),
        ],
      ),
    );
  }
}