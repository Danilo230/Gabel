import 'package:flutter/material.dart';

class NewCustomerModal extends StatelessWidgets {
  const NewCustomerModal({super.key});

  static void show(BuildContext context) {
    ShowModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NewCustomerModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF5C2483);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
      ),
      padding: const EdgeInsets.only(
      ),
    ),
  },
}
