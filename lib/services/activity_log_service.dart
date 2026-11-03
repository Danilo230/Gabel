import 'package:gabel/data/models/activity_log_model.dart';
import 'package:gabel/data/models/paged_result_model.dart';
import 'package:gabel/data/repositories/activity_log_repository.dart';

class ActivityLogService {
  final ActivityLogRepository _activityLogRepository;

  ActivityLogService(this._activityLogRepository);

  Future<PagedResultModel<ActivityLogModel>> getAll({
    int pageNumber = 1,
    int pageSize = 15,
    String? level,
    DateTime? from,
    DateTime? to,
  }) async {
    if (pageNumber <= 0 || pageSize <= 0) {
      throw const FormatException(
        'Los parámetros de paginación no son válidos',
      );
    }
    if (from != null && to != null && from.isAfter(to)) {
      throw const FormatException(
        'La fecha inicial no puede ser mayor a la fecha final',
      );
    }

    // Las fechas elegidas son locales (solo día). Se envía el inicio del día
    // inicial y el final del día final, convertidos a UTC.
    final String? fromUtc = from == null
        ? null
        : DateTime(from.year, from.month, from.day).toUtc().toIso8601String();
    final String? toUtc = to == null
        ? null
        : DateTime(to.year, to.month, to.day, 23, 59, 59, 999)
            .toUtc()
            .toIso8601String();

    return await _activityLogRepository.getAll({
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
      if (level != null) 'level': level,
      if (fromUtc != null) 'from': fromUtc,
      if (toUtc != null) 'to': toUtc,
    });
  }
}
