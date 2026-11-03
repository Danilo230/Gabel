import 'package:flutter/material.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/data/models/activity_log_model.dart';
import 'package:gabel/presentation/providers/user_provider.dart' show ViewStatus;
import 'package:gabel/services/activity_log_service.dart';

class ActivityLogProvider extends ChangeNotifier {
  static const int _pageSize = 15;

  final ActivityLogService _activityLogService;
  ActivityLogProvider(this._activityLogService);

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  List<ActivityLogModel> _logs = [];
  List<ActivityLogModel> get logs => _logs;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPages = 1;
  int get totalPages => _totalPages;

  int _totalRecords = 0;
  int get totalRecords => _totalRecords;

  // Filtros aplicados actualmente
  String? _level;
  DateTime? _from;
  DateTime? _to;
  bool get hasActiveFilters => _level != null || _from != null || _to != null;

  Future<void> fetchLogs({int pageNumber = 1}) async {
    if (_viewStatus == ViewStatus.loading) return;

    _viewStatus = ViewStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _activityLogService.getAll(
        pageNumber: pageNumber,
        pageSize: _pageSize,
        level: _level,
        from: _from,
        to: _to,
      );
      _logs = result.items;
      _currentPage = result.pageNumber;
      _totalPages = result.totalPages;
      _totalRecords = result.totalRecords;
      _viewStatus = ViewStatus.success;
    } on ServerException catch (e) {
      _errorMessage = e.statusCode == 403
          ? 'No tienes permiso para ver el registro de actividades.'
          : 'No se pudo cargar el registro de actividades.';
      _viewStatus = ViewStatus.error;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } on FormatException catch (e) {
      _errorMessage = e.message;
      _viewStatus = ViewStatus.error;
    } catch (e, stack) {
      debugPrint('ERROR FETCH ACTIVITY LOGS: $e');
      debugPrint('$stack');
      _errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo más tarde.';
      _viewStatus = ViewStatus.error;
    }

    notifyListeners();
  }

  Future<void> applyFilters({String? level, DateTime? from, DateTime? to}) {
    _level = level;
    _from = from;
    _to = to;
    return fetchLogs();
  }

  Future<void> clearFilters() => applyFilters();

  Future<void> refresh() => fetchLogs(pageNumber: _currentPage);
}
