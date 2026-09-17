import 'package:flutter/material.dart';

class CustomerSearchBar extends StatelessWidget {
  const CustomerSearchBar({super.key});
  static const Color primaryColor = Color(0xFF5C2483);

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
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Color(0xFF9E9E9E), size: 22),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Buscar clientes...',
                    style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                  ),
                ),
                Icon(Icons.tune, color: primaryColor, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ],
    );
  }
}
