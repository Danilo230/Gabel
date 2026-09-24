import 'package:flutter/material.dart';
import 'product_modal.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({super.key});

  static const Color moradoPrincipal = Color(0xFF5C2483);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Color(0xFF9E9E9E), size: 22),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Buscar productos...',
                    style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                  ),
                ),
                Icon(Icons.tune, color: moradoPrincipal, size: 20),
              ],
            ),
          ),
        ),

        
        const SizedBox(width: 10),
        Material(
          color: moradoPrincipal,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => NewProductModal.show(context),
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ),
      ],
    );
  }
}
