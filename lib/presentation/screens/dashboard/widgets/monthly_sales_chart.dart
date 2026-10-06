import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

// grafico de barras que muestra las ventas mensuales

class MonthlySale {
  final String month;
  final double amount;

  const MonthlySale(this.month, this.amount);
}

class MonthlySalesChart extends StatelessWidget {
  final String title;
  final List<MonthlySale> data;
  final String? highlightedMonth;

  const MonthlySalesChart({
    super.key,
    this.title = 'Ventas Mensuales',
    required this.data,
    this.highlightedMonth,
  });

  @override
  Widget build(BuildContext context) {
    final double maxAmount = data.isEmpty
        ? 1
        : data.map((d) => d.amount).reduce((a, b) => a > b ? a : b);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
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
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.map((item) {
                final bool highlighted = item.month == highlightedMonth;
                final double ratio =
                    maxAmount == 0 ? 0 : item.amount / maxAmount;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: FractionallySizedBox(
                            alignment: Alignment.bottomCenter,
                            heightFactor: ratio.clamp(0.05, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: highlighted
                                    ? AppColors.primaryPurple
                                    : AppColors.lightPurple,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.month,
                          style: TextStyle(
                            fontSize: 13,
                            color: highlighted
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight: highlighted
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
