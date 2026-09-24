import 'package:flutter/material.dart';

class EditServiceModal extends StatelessWidget {
  const EditServiceModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EditServiceModal(),
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

      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),

      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Editar Servicio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: morado,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Colors.grey),
                  splashRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: 16),

            _campoTexto(
              label: 'Nombre del servicio',
              hint: 'Ej. Corte',
            ),
            const SizedBox(height: 14),

            _campoTexto(
              label: 'Descripción',
              hint: 'Detalles del servicio...',
              maxLines: 3,
            ),
            const SizedBox(height: 14),

            _campoSeleccionar(
              label: 'Categoría',
              hint: 'Seleccionar categoría',
              onTap: () {},
            ),
            const SizedBox(height: 14),

            _campoSeleccionar(
              label: 'Producto Utilizado',
              hint: 'Seleccionar producto',
              onTap: () {},
            ),
            const SizedBox(height: 14),

            _campoTexto(
              label: 'Precio',
              hint: '0.00',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),

            _campoSeleccionar(
              label: 'Estado',
              hint: 'Seleccionar estado',
              onTap: () {},
            ),
            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.add, color: Colors.white, size: 20),
                label: const Text(
                  'Guardar cambios',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: morado,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoTexto({
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A4A4A),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFB0B0B0), fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            filled: true,
            fillColor: const Color(0xFFF9F9FB),
            
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF5C2483)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _campoSeleccionar({
    required String label,
    required String hint,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A4A4A),
          ),
        ),

        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E5EA)),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hint,
                  style: const TextStyle(
                    color: Color(0xFFB0B0B0),
                    fontSize: 13,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF757575),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}