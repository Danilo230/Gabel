import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final String customerName;
  final String customerLastName;
  final String customerEmail;
  final String customerPhone;

  const CustomerCard({
    Key? key,
    required this.customerName,
    required this.customerLastName,
    required this.customerEmail,
    required this.customerPhone,
  });

  static const Color primaryColor = Color(0xFF5C2483);
  static const Color bgIconColo = Color(0xFFEFE8F6);
  static const Color secondaryText = Color(0xFF757575);
  static const Color actionIcon = Color(0xFF5C2483);
  static const Color deleteIcon = Color(0xFFB24C5D);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150.0,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${customerName} ${customerLastName}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(customerEmail, style: const TextStyle(fontSize: 14.0)),
              const SizedBox(height: 8.0),
              Text(customerPhone, style: const TextStyle(fontSize: 14.0)),
              const SizedBox(height: 8.0),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.visibility_off_outlined,
                    color: actionIcon,
                    size: 20,
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.edit_outlined, color: actionIcon, size: 20),
                  SizedBox(width: 16),
                  Icon(
                    Icons.delete_outline_rounded,
                    color: deleteIcon,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
