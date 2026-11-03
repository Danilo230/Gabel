import 'package:flutter/material.dart';
import 'package:gabel/presentation/providers/authenticatio_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_header.dart';
import 'widgets/settings_option.dart';
import 'widgets/settings_section.dart';
import 'package:gabel/presentation/screens/profile/profile.dart';
import 'package:gabel/presentation/screens/logs/logs.dart';
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
    final bool isSalesperson =
        context.watch<AuthenticationProvider>().isSalesperson;

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
                ],
              ),

              if (!isSalesperson) ...[
                const SizedBox(height: 24),

                SettingsSection(
                  qualification: 'SISTEMA',
                  options: [
                    SettingsOption(
                      icon: Icons.history,
                      qualification: 'Registro de Actividades',
                      caption: 'Consulta la actividad del sistema',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ActivityLogsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 24),

              // CERRAR SESIÓN
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await context.read<AuthenticationProvider>().logout();
                    navigator.pushNamedAndRemoveUntil('/login', (route) => false);
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