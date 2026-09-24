import 'package:flutter/material.dart';
import 'edit_service_modal.dart';
import 'delete_service.dart';


class ServiceCard extends StatelessWidget {
  final String nombre;
  final String productoUtilizado;
  final String precio;
  final IconData icono;

  const ServiceCard({
    super.key,
    required this.nombre,
    required this.productoUtilizado,
    required this.precio,
    required this.icono,
  });

  static const Color moradoPrincipal = Color(0xFF5C2483);
  static const Color moradoFondoIcono = Color(0xFFEFE8F6);
  static const Color textoSecundario = Color(0xFF757575);
  static const Color iconoAccion = Color(0xFF5C2483);
  static const Color iconoEliminar = Color(0xFFB24C5D);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: moradoFondoIcono,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icono,
                  color: moradoPrincipal,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF212121),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Producto: $productoUtilizado',
                      style: const TextStyle(
                        color: textoSecundario,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Precio',
                    style: TextStyle(color: textoSecundario, fontSize: 11),
                  ),
                  Text(
                    precio,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: moradoPrincipal,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  const Icon(Icons.visibility_outlined, color: iconoAccion, size: 20),
                  const SizedBox(width: 16),

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.edit_outlined, color: Color(0xFF5C2483), size: 20),
                    onPressed: () {
                      EditServiceModal.show(context);
                    },
                  ),

                  const SizedBox(width: 16),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 20),
                    onPressed: () {
                      DeleteService.show(context);
                    },
                    
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
