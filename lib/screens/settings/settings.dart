import 'package:flutter/material.dart';
import 'widgets/settings_option.dart';
import 'widgets/settings_section.dart';

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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ENCABEZADO
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Configuración',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C2483),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      // Más adelante navegaremos al perfil
                    },
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      size: 32,
                      color: Color(0xFF424242),
                    ),
                  ),
                ],
              ),

              const Text(
                'Gestiona tu cuenta y preferencias del sistema.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              // CUENTA
              SettingsSection(
                titulo: 'CUENTA',
                opciones: [
                  SettingsOption(
                    icono: Icons.person_outline,
                    titulo: 'Mi perfil',
                    subtitulo: 'Datos personales',
                    onTap: () {
                      // Más adelante navegaremos al perfil
                    },
                  ),

                  SettingsOption(
                    icono: Icons.lock_outline,
                    titulo: 'Cambiar contraseña',
                    subtitulo: 'Seguridad de la cuenta',
                    onTap: () {
                      // Más adelante navegaremos
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // PREFERENCIAS
              SettingsSection(
                titulo: 'PREFERENCIAS',
                opciones: [
                  SettingsOption(
                    icono: Icons.dark_mode_outlined,
                    titulo: 'Modo oscuro',
                    subtitulo: 'Ajusta la apariencia visual',

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
                    icono: Icons.notifications_none,
                    titulo: 'Notificaciones',
                    subtitulo: 'Configura las alertas de la aplicación',

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
                    icono: Icons.text_fields,
                    titulo: 'Tamaño de letra',
                    subtitulo: 'Ajusta la escala de lectura',

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
                    // Más adelante regresaremos al Login
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