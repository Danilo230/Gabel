import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/Logo.jpeg'),
              ),

              const Text(
                'Gabel',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF7557AC)),
              ),
              
              const SizedBox(height: 5),

              const Text(
                'Bienvenido de nuevo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF7557AC)),
              ),

              const Text(
                'Ingresa tus credenciales para acceder',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 47),
              
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Usuario',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Ingresa tu usuario',
                  prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF7557AC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contraseña',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Ingresa tu contraseña',
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF7557AC)),
                  suffixIcon: const Icon(Icons.visibility_outlined, color: Color(0xFF7557AC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), backgroundColor: Color(0xFF7557AC),
                ),
                child: Text('Iniciar Sesión', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}