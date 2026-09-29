import 'package:flutter/material.dart';
import 'edit_product_modal.dart';
import 'delete_product.dart';
import 'product_detail_modal.dart';

class ProductCard extends StatelessWidget {
  final String nombre;
  final String? sku;
  final String precio;
  final IconData icono;
  final bool sinStock;

  const ProductCard({
    super.key,
    required this.nombre,
    this.sku,
    required this.precio,
    required this.icono,
    this.sinStock = false,
  });

  static const Color moradoPrincipal = Color(0xFF5C2483);
  static const Color moradoFondoIcono = Color(0xFFEFE8F6);
  static const Color textoSecundario = Color(0xFF757575);
  static const Color rojoSinStock = Color(0xFFD3455B);
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
                  color: sinStock ? Colors.grey : moradoPrincipal,
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
                    if (sinStock)
                      Row(
                        children: const [
                          Icon(Icons.warning_amber_rounded, size: 14, color: rojoSinStock),
                          SizedBox(width: 4),
                          Text(
                            'Sin Stock',
                            style: TextStyle(
                              color: rojoSinStock,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    else if (sku != null)
                      Text(
                        sku!,
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
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.visibility_outlined, color: Color(0xFF5C2483), size: 20),
                    onPressed: () {
                      ProductDetailModal.show(context);
                    },
                  ),

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.edit_outlined, color: Color(0xFF5C2483), size: 20),
                    onPressed: () {
                      EditProductModal.show(context);
                    },
                  ),
                  
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 20),
                    onPressed: () {
                      DeleteProduct.show(context);
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
