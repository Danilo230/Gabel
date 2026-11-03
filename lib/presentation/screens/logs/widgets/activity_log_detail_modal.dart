import 'package:flutter/material.dart';
import 'package:gabel/data/models/activity_log_model.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_modal_sheet.dart';
import 'activity_log_card.dart';

class ActivityLogDetailModal extends StatelessWidget {
  final ActivityLogModel log;

  const ActivityLogDetailModal({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return CustomModalSheet(
      title: 'Detalle de actividad',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ActivityLogCard.backgroundOf(log),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              log.levelLabel,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: ActivityLogCard.accentOf(log),
              ),
            ),
          ),
          const SizedBox(height: 18),
          _row('Petición', '${log.method} ${log.path}'),
          _row('Código de estado', '${log.statusCode}'),
          _row('Fecha y hora', log.formattedTimestamp),
          _row('Usuario', log.userId ?? 'Anónimo'),
          _row('Duración', '${log.elapsedMs} ms'),
          _row('Id de traza', log.traceId, selectable: true),
          if (log.error != null) _row('Error', log.error!, isError: true),
        ],
      ),
    );
  }

  Widget _row(
    String label,
    String value, {
    bool selectable = false,
    bool isError = false,
  }) {
    final style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: isError ? AppColors.red : AppColors.textPrimary,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          selectable
              ? SelectableText(value, style: style)
              : Text(value, style: style),
        ],
      ),
    );
  }
}
