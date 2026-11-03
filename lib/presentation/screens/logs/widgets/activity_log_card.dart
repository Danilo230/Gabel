import 'package:flutter/material.dart';
import 'package:gabel/data/models/activity_log_model.dart';

import '../../../theme/app_colors.dart';

class ActivityLogCard extends StatelessWidget {
  static const Color _warning = Color(0xFFB26A00);
  static const Color _warningBg = Color(0xFFFFF3E0);

  final ActivityLogModel log;
  final VoidCallback? onTap;

  const ActivityLogCard({super.key, required this.log, this.onTap});

  static Color accentOf(ActivityLogModel log) {
    if (log.isError) return AppColors.red;
    if (log.isWarning) return _warning;
    return AppColors.primaryPurple;
  }

  static Color backgroundOf(ActivityLogModel log) {
    if (log.isError) return AppColors.lightRed;
    if (log.isWarning) return _warningBg;
    return AppColors.paleLavender;
  }

  @override
  Widget build(BuildContext context) {
    final Color accent = accentOf(log);
    final Color accentBg = backgroundOf(log);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadowColor,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightPurple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        log.method,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        log.path,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: accentBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${log.statusCode}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(height: 1, color: AppColors.borderGrey),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _info(Icons.schedule, log.formattedTimestamp),
                    _info(Icons.person_outline, log.userId ?? 'Anónimo'),
                    _info(Icons.timer_outlined, '${log.elapsedMs} ms'),
                  ],
                ),
                if (log.error != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.paleRed,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.redBorder),
                    ),
                    child: Text(
                      log.error!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: AppColors.textTertiary),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
