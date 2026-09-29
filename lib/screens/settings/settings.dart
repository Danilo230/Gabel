import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import 'widgets/settings_option.dart';
import 'widgets/settings_section.dart';
import 'package:gabel/screens/profile/profile.dart';
import '../../widgets/app_routes.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool modoOscuro = false;
  bool notificaciones = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FA),
      appBar: const AppHeader(title: 'Configuración'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gestiona tu cuenta y preferencias del sistema.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              SettingsSection(
                qualification: 'CUENTA',
                options: [
                  SettingsOption(
                    icon: Icons.person_outline,
                    qualification: 'Mi perfil',
                    caption: 'Datos personales',
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                    },
                  ),                
                ],
              ),

              const SizedBox(height: 24),

              SettingsSection(
                qualification: 'PREFERENCIAS',
                options: [
                  SettingsOption(
                    icon: Icons.dark_mode_outlined,
                    qualification: 'Modo oscuro',
                    caption: 'Ajusta la apariencia visual',

                    trailing: Switch(
                      value: modoOscuro,
                      activeThumbColor: const Color(0xFF5C2483),
                      onChanged: (valor) {
                        setState(() {
                          modoOscuro = valor;
                        });
                      },
                    ),
                  ),

                  SettingsOption(
                    icon: Icons.notifications_none,
                    qualification: 'Notificaciones',
                    caption: 'Configura las alertas de la aplicación',

                    trailing: Switch(
                      value: notificaciones,
                      activeThumbColor: const Color(0xFF5C2483),
                      onChanged: (valor) {
                        setState(() {
                          notificaciones = valor;
                        });
                      },
                    ),
                  ),

                  SettingsOption(
                    icon: Icons.text_fields,
                    qualification: 'Tamaño de letra',
                    caption: 'Ajusta la escala de lectura',

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Mediano',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(width: 4),

                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // CERRAR SESIÓN
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login.toString(), (route) => false);
                  },

                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFFD3455B),
                  ),

                  label: const Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      color: Color(0xFFD3455B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFD3455B),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}