import 'package:gabel/core/constants/api_constants.dart';
import 'package:gabel/core/errors/app_exception.dart';
import 'package:gabel/core/network/api_client.dart';
import 'package:gabel/data/models/activity_log_model.dart';
import 'package:gabel/data/models/paged_result_model.dart';

class ActivityLogRepository {
  final ApiClient _apiClient;

  ActivityLogRepository(this._apiClient);

  Future<PagedResultModel<ActivityLogModel>> getAll(
    Map<String, String>? params,
  ) async {
    final data = await _apiClient.get(ApiConstants.activityLogs, query: params);
    if (data is! Map<String, dynamic>) throw ParsingException();

    return PagedResultModel.fromJson(data, ActivityLogModel.fromJson);
  }
}
