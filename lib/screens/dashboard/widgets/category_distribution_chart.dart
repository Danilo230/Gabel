import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

// grafico de dona que muestra la distribucion de productos por categoria

class ProductCategory {
  final String name;
  final double percentage;
  final Color color;

  const ProductCategory({
    required this.name,
    required this.percentage,
    required this.color,
  });
}

class CategoryDistributionChart extends StatelessWidget {
  final String title;
  final List<ProductCategory> categories;

  const CategoryDistributionChart({
    super.key,
    this.title = 'Distribucion de Productos por Categoria',
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final double total =
        categories.fold<double>(0, (sum, c) => sum + c.percentage);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: CustomPaint(
                  painter: _DonutPainter(categories: categories, total: total),
                  child: Center(
                    child: Text(
                      '${total.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryPurple,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: categories
                      .map((category) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: category.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    '${category.name} (${category.percentage.toStringAsFixed(0)}%)',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<ProductCategory> categories;
  final double total;

  _DonutPainter({required this.categories, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    if (total <= 0) return;

    const double thickness = 22;
    final Rect rect = Rect.fromLTWH(
      thickness / 2,
      thickness / 2,
      size.width - thickness,
      size.height - thickness,
    );

    double start = -math.pi / 2;

    for (final category in categories) {
      final double sweep = (category.percentage / total) * 2 * math.pi;
      final Paint paint = Paint()
        ..color = category.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness;

      canvas.drawArc(rect, start, sweep - 0.02, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.categories != categories || oldDelegate.total != total;
}
