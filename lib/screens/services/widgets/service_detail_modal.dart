import 'package:flutter/material.dart';

class ServiceDetailModal extends StatelessWidget {
  final String nombre;
  final String precio;
  final String categoria;
  final String productoUtilizado;
  final String estado;
  final String descripcion;

  const ServiceDetailModal({
    super.key,
    this.nombre = 'Corte y Peinado Profesional',
    this.precio = '\$35.00',
    this.categoria = 'Cuidado Capilar',
    this.productoUtilizado = 'Shampoo Revitalizante, Acondicionador Color Protec',
    this.estado = 'Activo',
    this.descripcion = 'Servicio integral que incluye lavado con masaje capilar, corte de diseño personalizado y peinado con secado profesional.',
  });

  static void show(
    BuildContext context, {
    String? nombre,
    String? precio,
    String? categoria,
    String? productoUtilizado,
    String? estado,
    String? descripcion,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ServiceDetailModal(
        nombre: nombre ?? 'Corte y Peinado Profesional',
        precio: precio ?? '\$35.00',
        categoria: categoria ?? 'Cuidado Capilar',
        productoUtilizado: productoUtilizado ?? 'Shampoo Revitalizante, Acondicionador Color Protec',
        estado: estado ?? 'Activo',
        descripcion: descripcion ?? 'Servicio integral que incluye lavado con masaje capilar, corte de diseño personalizado y peinado con secado profesional.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const morado = Color(0xFF5C2483);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.visibility_outlined, color: morado, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Detalle del Servicio',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: morado,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Colors.grey),
                  splashRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FB),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5E5EA)),
              ),

              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EEF6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.content_cut_rounded,
                      color: morado,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nombre,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222222),
                          ),
                        ),

                        const SizedBox(height: 4),
                        Text(
                          categoria,
                          style: const TextStyle(
                            color: Color(0xFF8E8E93),
                            fontSize: 12,
                          ),
                        ),
                      ],

                    ),
                  ),
                  Text(
                    precio,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: morado,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Descripción',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FB),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE5E5EA)),
              ),
              child: Text(
                descripcion,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF555555),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 16),

            _itemInformacion(
              icon: Icons.category_outlined,
              label: 'Categoría',
              valor: categoria,
            ),
            const SizedBox(height: 10),
            _itemInformacion(
              icon: Icons.inventory_2_outlined,
              label: 'Producto Utilizado',
              valor: productoUtilizado,
            ),
            const SizedBox(height: 10),

            _itemEstado(
              label: 'Estado',
              estado: estado,
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD1D5DB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cerrar',
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemInformacion({
    required IconData icon,
    required String label,
    required String valor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E5EA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(icon, color: const Color(0xFF8E8E93), size: 18),
          ),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              valor,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemEstado({
    required String label,
    required String estado,
  }) {
    final bool esActivo = estado.toLowerCase() == 'activo';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E5EA)),
      ),
      child: Row(
        children: [
          Icon(
            esActivo ? Icons.check_circle_outline_rounded : Icons.pause_circle_outline_rounded,
            color: esActivo ? const Color(0xFF2E7D32) : const Color(0xFF8E8E93),
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: esActivo ? const Color(0xFFE8F5E9) : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              estado,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: esActivo ? const Color(0xFF2E7D32) : const Color(0xFF757575),
              ),
            ),
          ),
        ],
      ),
    );
  }
}