import 'package:flutter/material.dart';
import 'package:gabel/core/di/injection.dart';
import 'package:gabel/presentation/providers/activity_log_provider.dart';
import 'package:gabel/presentation/providers/user_provider.dart' show ViewStatus;
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_date_filter.dart';
import '../../widgets/custom_filter_dropdown.dart';
import '../../widgets/custom_modal_sheet.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/custom_refresh_scroll_view.dart';
import 'widgets/activity_log_card.dart';
import 'widgets/activity_log_detail_modal.dart';

class ActivityLogsScreen extends StatefulWidget {
  const ActivityLogsScreen({super.key});

  @override
  State<ActivityLogsScreen> createState() => _ActivityLogsScreenState();
}

class _ActivityLogsScreenState extends State<ActivityLogsScreen> {
  static const String _allLevels = 'Todos los niveles';

  // etiqueta mostrada -> valor que espera el API
  static const Map<String, String?> _levels = {
    _allLevels: null,
    'Información': 'Information',
    'Advertencia': 'Warning',
    'Error': 'Error',
  };

  String _levelLabel = _allLevels;
  DateTime? _from;
  DateTime? _to;

  bool get _hasDraftFilters =>
      _levelLabel != _allLevels || _from != null || _to != null;

  String _formatDate(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(date.day)}/${two(date.month)}/${date.year}';
  }

  Future<void> _pickDate({required bool isStart}) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isStart ? _from : _to) ?? now,
      firstDate: DateTime(2020),
      lastDate: now,
    );

    if (picked == null || !mounted) return;

    setState(() {
      if (isStart) {
        _from = picked;
      } else {
        _to = picked;
      }
    });
  }

  void _applyFilters(ActivityLogProvider provider) {
    if (_from != null && _to != null && _from!.isAfter(_to!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La fecha inicial no puede ser mayor a la final.'),
        ),
      );
      return;
    }

    provider.applyFilters(level: _levels[_levelLabel], from: _from, to: _to);
  }

  void _clearFilters(ActivityLogProvider provider) {
    setState(() {
      _levelLabel = _allLevels;
      _from = null;
      _to = null;
    });
    provider.clearFilters();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ActivityLogProvider>()..fetchLogs(),
      child: Consumer<ActivityLogProvider>(
        builder: (context, logs, _) {
          final bool showSpinner = logs.logs.isEmpty &&
              (logs.viewStatus == ViewStatus.initial ||
                  logs.viewStatus == ViewStatus.loading);

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: const AppHeader(title: 'Registro de Actividades'),
            body: SafeArea(
              child: CustomRefreshScrollView(
                onRefresh: logs.refresh,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFilterDropdown(
                      label: 'Filtrar por nivel',
                      value: _levelLabel,
                      items: _levels.keys.toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => _levelLabel = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomDateFilter(
                      startDate:
                          _from == null ? 'Fecha inicial' : _formatDate(_from!),
                      endDate: _to == null ? 'Fecha final' : _formatDate(_to!),
                      onStartDateTap: () => _pickDate(isStart: true),
                      onEndDateTap: () => _pickDate(isStart: false),
                      onFilterPressed: () => _applyFilters(logs),
                    ),
                    if (_hasDraftFilters || logs.hasActiveFilters)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => _clearFilters(logs),
                          child: const Text(
                            'Limpiar filtros',
                            style: TextStyle(color: AppColors.primaryPurple),
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    if (showSpinner)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      )
                    else if (logs.viewStatus == ViewStatus.error)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Text(
                              logs.errorMessage ??
                                  'Ocurrió un error inesperado.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: 'Reintentar',
                              onPressed: logs.refresh,
                            ),
                          ],
                        ),
                      )
                    else if (logs.logs.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: Text(
                            'No se encontraron registros de actividad.',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    else ...[
                      Text(
                        '${logs.totalRecords} registros',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (final log in logs.logs)
                        ActivityLogCard(
                          log: log,
                          onTap: () => CustomModalSheet.show(
                            context: context,
                            child: ActivityLogDetailModal(log: log),
                          ),
                        ),
                      const SizedBox(height: 6),
                      if (logs.totalPages > 1)
                        Center(
                          child: CustomPagination(
                            currentPage: logs.currentPage,
                            totalPages: logs.totalPages,
                            onPageTap: (page) {
                              if (page != logs.currentPage) {
                                logs.fetchLogs(pageNumber: page);
                              }
                            },
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
