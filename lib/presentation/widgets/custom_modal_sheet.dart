import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// modal personalizable

class CustomModalSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CustomModalSheet({
    super.key,
    required this.title,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(20, 18, 20, 24),
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.45),
      builder: (_) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.88;

    // Altura ocupada por el teclado.
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 12, 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.primaryPurple,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1, color: AppColors.borderGrey),

            Flexible(
              child: SingleChildScrollView(padding: padding, child: child),
            ),

            //opcion de editar
          ],
        ),
      ),
    );
  }
}
