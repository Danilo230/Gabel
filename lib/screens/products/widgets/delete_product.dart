import 'package:flutter/material.dart';

class DeleteProduct extends StatelessWidget {
  const DeleteProduct({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const DeleteProduct(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const rojoPrincipal = Color(0xFFDC2626);
    const rojoFondo = Color(0xFFFDE8E8);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Eliminar Producto',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Color(0xFF8E8E93), size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 18,
                ),
              ],
            ),
            const SizedBox(height: 20),

            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: rojoFondo,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.delete_outline_rounded,
                color: rojoPrincipal,
                size: 32,
              ),
            ),
            const SizedBox(height: 18),

            const Text(
              '¿Estás seguro de que deseas eliminar este producto?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
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
                  'Cancelar',
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rojoPrincipal,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Eliminar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}