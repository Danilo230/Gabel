import 'package:flutter/material.dart';

class ProductDetailModal extends StatelessWidget {
  final String nombre;
  final String sku;
  final String precio;
  final String categoria;
  final String unidadMedida;
  final String proveedor;
  final String marca;
  final String estado;
  final String descripcion;
  final bool enStock;
  final int stockDisponible;

  const ProductDetailModal({
    super.key,
    this.nombre = 'Shampoo Revitalizante',
    this.sku = 'SH-1029',
    this.precio = '\$24.50',
    this.categoria = 'Cuidado Capilar',
    this.unidadMedida = '500 ml',
    this.proveedor = 'Distribuidora Belleza Express',
    this.marca = "L'Oréal Professionnel",
    this.estado = 'Activo', 
    this.descripcion = 'Fórmula enriquecida con extractos naturales y keratina para restaurar el cabello maltratado.',
    this.enStock = true,
    this.stockDisponible = 24,
  });

  static void show(
    BuildContext context, {
    String? nombre,
    String? sku,
    String? precio,
    String? categoria,
    String? unidadMedida,
    String? proveedor,
    String? marca,
    String? estado,
    String? descripcion,
    bool? enStock,
    int? stockDisponible,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductDetailModal(
        nombre: nombre ?? 'Shampoo Revitalizante',
        sku: sku ?? 'SH-1029',
        precio: precio ?? '\C240.00',
        categoria: categoria ?? 'Cuidado Capilar',
        unidadMedida: unidadMedida ?? 'Botella (500 ml)',
        proveedor: proveedor ?? 'Distribuidora Belleza Express',
        marca: marca ?? "L'Oréal Professionnel",
        estado: estado ?? 'Activo',
        descripcion: descripcion ?? 'Fórmula enriquecida con extractos naturales y keratina para restaurar el cabello maltratado.',
        enStock: enStock ?? true,
        stockDisponible: stockDisponible ?? 24,
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
                      'Detalle del Producto',
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
                      Icons.shopping_bag_outlined,
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
                        Row(
                          children: [
                            Text(
                              'SKU: $sku',
                              style: const TextStyle(
                                color: Color(0xFF8E8E93),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: enStock ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                enStock ? '$stockDisponible en stock' : 'Sin Stock',
                                style: TextStyle(
                                  color: enStock ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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

            _itemInformacion(icon: Icons.straighten_rounded, label: 'Unidad de Medida', valor: unidadMedida),
            const SizedBox(height: 10),
            _itemInformacion(icon: Icons.category_outlined, label: 'Categoría', valor: categoria),
            const SizedBox(height: 10),
            _itemInformacion(icon: Icons.local_shipping_outlined, label: 'Proveedor', valor: proveedor),
            const SizedBox(height: 10),
            _itemInformacion(icon: Icons.branding_watermark_outlined, label: 'Marca', valor: marca),
            const SizedBox(height: 10),
            _itemEstado(label: 'Estado', estado: estado),
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
        children: [
          Icon(icon, color: const Color(0xFF8E8E93), size: 18),
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
              overflow: TextOverflow.ellipsis,
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